import '../models/file_pick_result.dart';

/// 파일 시스템 접근을 추상화한 도메인 리포지토리 인터페이스입니다.
abstract class FileRepository {
  /// 오디오 파일 선택을 시도합니다.
  ///
  /// 권한 요청과 파일 선택 다이얼로그까지 포함된 결과를 반환합니다.
  /// 반환값은 선택 결과를 담은 [FilePickResult] 객체입니다.
  Future<FilePickResult> pickAudioFile();

  /// 시스템 앱 설정 화면을 열어 사용자가 권한을 직접 부여하도록 유도합니다.
  ///
  /// 반환값은 설정 화면 호출 성공 여부입니다.
  Future<bool> openAppSettings();
}
