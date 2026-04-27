import 'dart:async';

import 'package:flutter_sharing_intent/flutter_sharing_intent.dart';
import 'package:flutter_sharing_intent/model/sharing_file.dart';

import '../common/logger/app_logger.dart';

/// 외부 앱에서 공유받은 텍스트/URL 을 노출하는 서비스입니다.
///
/// 콜드 스타트 시 초기 공유 데이터와 백그라운드/포그라운드 진입 시
/// 발생하는 공유 이벤트를 모두 처리합니다.
class SharingIntentService {
  final _logger = AppLogger.getLogger('SharingIntent');
  final _controller = StreamController<String>.broadcast();
  StreamSubscription<List<SharedFile>>? _subscription;

  /// 외부에서 공유된 텍스트/URL 이 들어올 때마다 발행되는 스트림입니다.
  Stream<String> get sharedTextStream => _controller.stream;

  /// 콜드 스타트 시 외부에서 공유된 초기 텍스트를 조회합니다.
  ///
  /// 반환값은 공유된 텍스트 문자열, 없으면 null 입니다.
  Future<String?> getInitialSharedText() async {
    try {
      final initialMedia = await FlutterSharingIntent.instance
          .getInitialSharing();
      if (initialMedia.isNotEmpty &&
          (initialMedia.first.type == SharedMediaType.TEXT ||
              initialMedia.first.type == SharedMediaType.URL)) {
        return initialMedia.first.value;
      }
    } catch (e) {
      _logger.severe('Failed to get initial shared media: $e');
    }
    return null;
  }

  /// 백그라운드/포그라운드 공유 이벤트 구독을 시작합니다.
  ///
  /// 한 번만 호출하면 되며, [dispose] 로 정리합니다.
  void start() {
    _subscription ??= FlutterSharingIntent.instance.getMediaStream().listen(
      (value) {
        if (value.isNotEmpty &&
            (value.first.type == SharedMediaType.TEXT ||
                value.first.type == SharedMediaType.URL)) {
          final text = value.first.value;
          if (text != null && text.isNotEmpty) {
            _controller.add(text);
          }
        }
      },
      onError: (Object err) {
        _logger.severe('getMediaStream error: $err');
      },
    );
  }

  /// 구독 및 스트림을 정리합니다.
  Future<void> dispose() async {
    await _subscription?.cancel();
    _subscription = null;
    await _controller.close();
  }
}
