import '../models/audio_source.dart';

/// 오디오 분리 처리를 담당하는 리포지토리 인터페이스입니다.
abstract class AudioRepository {
  /// 입력된 오디오 소스를 분리(처리) 요청합니다.
  ///
  /// [source] 분리할 입력 소스 정보
  /// 반환값은 처리 성공 여부입니다.
  Future<bool> separate({required AudioSource source});
}
