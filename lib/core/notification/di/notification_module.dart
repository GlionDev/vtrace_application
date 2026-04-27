import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../sharing_intent_service.dart';

part 'notification_module.g.dart';

/// 외부 공유 인텐트 처리를 담당하는 [SharingIntentService] 를 제공합니다.
///
/// keepAlive 로 앱 수명 동안 유지되며, [Ref.onDispose] 로 정리됩니다.
/// 반환값은 공유 텍스트 스트림을 노출하는 서비스 객체입니다.
@Riverpod(keepAlive: true)
SharingIntentService sharingIntentService(Ref ref) {
  final service = SharingIntentService();
  service.start();
  ref.onDispose(service.dispose);
  return service;
}

/// 외부 공유로 들어온 텍스트(URL 등)를 노출하는 스트림 프로바이더입니다.
///
/// 반환값은 새로운 공유 텍스트가 발생할 때마다 발행되는 [Stream] 입니다.
@Riverpod(keepAlive: true)
Stream<String> sharedText(Ref ref) {
  return ref.watch(sharingIntentServiceProvider).sharedTextStream;
}
