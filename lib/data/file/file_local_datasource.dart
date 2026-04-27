import '../../core/file/file_service.dart';

/// 파일 시스템 접근을 추상화한 로컬 데이터소스입니다.
abstract class FileLocalDataSource {
  /// 오디오 파일 선택을 시도합니다.
  ///
  /// 반환값은 raw 결과를 담은 [FilePickRawResult] 객체입니다.
  Future<FilePickRawResult> pickAudioFile();

  /// 시스템 앱 설정 화면을 엽니다.
  ///
  /// 반환값은 설정 화면 호출 성공 여부입니다.
  Future<bool> openAppSettings();
}
