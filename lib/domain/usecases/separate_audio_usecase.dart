import '../models/audio_source.dart';
import '../repositories/audio_repository.dart';

/// 입력된 오디오 소스를 분리 요청하는 UseCase 입니다.
class SeparateAudioUseCase {
  final AudioRepository _repository;

  /// [SeparateAudioUseCase] 객체를 생성합니다.
  ///
  /// [repository] 오디오 처리를 위임할 리포지토리
  const SeparateAudioUseCase(this._repository);

  /// 분리 요청을 수행합니다.
  ///
  /// [source] 분리할 입력 소스 정보
  /// 반환값은 처리 성공 여부입니다.
  Future<bool> call({required AudioSource source}) {
    return _repository.separate(source: source);
  }
}
