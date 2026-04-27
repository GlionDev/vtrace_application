import '../repositories/file_repository.dart';

/// 시스템 앱 설정 화면을 여는 UseCase 입니다.
class OpenAppSettingsUseCase {
  final FileRepository _repository;

  /// [OpenAppSettingsUseCase] 객체를 생성합니다.
  ///
  /// [repository] 파일 처리를 위임할 리포지토리
  const OpenAppSettingsUseCase(this._repository);

  /// 시스템 앱 설정 화면을 엽니다.
  ///
  /// 반환값은 설정 화면 호출 성공 여부입니다.
  Future<bool> call() => _repository.openAppSettings();
}
