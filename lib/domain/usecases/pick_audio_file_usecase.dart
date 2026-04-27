import '../models/file_pick_result.dart';
import '../repositories/file_repository.dart';

/// 오디오 파일 선택 UseCase 입니다.
class PickAudioFileUseCase {
  final FileRepository _repository;

  /// [PickAudioFileUseCase] 객체를 생성합니다.
  ///
  /// [repository] 파일 처리를 위임할 리포지토리
  const PickAudioFileUseCase(this._repository);

  /// 파일 선택을 시도합니다.
  ///
  /// 반환값은 선택 결과를 담은 [FilePickResult] 객체입니다.
  Future<FilePickResult> call() => _repository.pickAudioFile();
}
