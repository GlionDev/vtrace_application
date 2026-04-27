import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';

/// 권한 요청 결과 종류를 나타냅니다.
enum FilePermissionStatus {
  /// 권한이 허용된 상태
  granted,

  /// 일시 거부된 상태(다시 요청 가능)
  denied,

  /// 영구 거부된 상태(설정 화면 안내 필요)
  permanentlyDenied,
}

/// 파일 선택 raw 결과를 담는 값 객체입니다.
///
/// 도메인 모델로의 변환은 데이터 계층의 datasource 가 담당합니다.
class FilePickRawResult {
  /// 권한 요청 결과
  final FilePermissionStatus permission;

  /// 선택된 파일 경로 (취소/거부 시 null)
  final String? path;

  /// 사용자가 다이얼로그에서 취소했는지 여부
  final bool isCancelled;

  /// [FilePickRawResult] 객체를 생성합니다.
  ///
  /// [permission] 권한 요청 결과
  /// [path] 선택된 파일 경로
  /// [isCancelled] 사용자 취소 여부
  const FilePickRawResult({
    required this.permission,
    this.path,
    this.isCancelled = false,
  });
}

/// 파일 시스템 접근(권한 요청 + 파일 선택)을 추상화한 서비스입니다.
class FileService {
  /// 오디오 파일 선택을 시도합니다.
  ///
  /// 권한 요청 → 파일 선택 다이얼로그 표시까지의 흐름을 한 번에 처리합니다.
  /// 반환값은 raw 결과를 담은 [FilePickRawResult] 객체입니다.
  Future<FilePickRawResult> pickAudioFile() async {
    var storageStatus = await Permission.storage.status;
    var audioStatus = await Permission.audio.status;

    if (!storageStatus.isGranted && !audioStatus.isGranted) {
      final statuses = await [
        Permission.storage,
        Permission.audio,
      ].request();
      storageStatus = statuses[Permission.storage] ?? PermissionStatus.denied;
      audioStatus = statuses[Permission.audio] ?? PermissionStatus.denied;
    }

    final isGranted = storageStatus.isGranted || audioStatus.isGranted;
    if (!isGranted) {
      final permanentlyDenied =
          storageStatus.isPermanentlyDenied ||
          audioStatus.isPermanentlyDenied;
      return FilePickRawResult(
        permission: permanentlyDenied
            ? FilePermissionStatus.permanentlyDenied
            : FilePermissionStatus.denied,
      );
    }

    final result = await FilePicker.platform.pickFiles(type: FileType.audio);
    if (result == null || result.files.single.path == null) {
      return const FilePickRawResult(
        permission: FilePermissionStatus.granted,
        isCancelled: true,
      );
    }

    return FilePickRawResult(
      permission: FilePermissionStatus.granted,
      path: result.files.single.path,
    );
  }

  /// 시스템 앱 설정 화면을 엽니다.
  ///
  /// 반환값은 설정 화면 호출 성공 여부입니다.
  Future<bool> openSettings() {
    return openAppSettings();
  }
}
