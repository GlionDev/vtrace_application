import '../../core/file/file_service.dart';
import '../../domain/models/file_pick_result.dart';

/// [FilePickRawResult] ↔ 도메인 모델 매핑 확장입니다.
extension FilePickRawResultMapper on FilePickRawResult {
  /// raw 결과를 도메인 모델 [FilePickResult] 로 변환합니다.
  ///
  /// 반환값은 변환된 [FilePickResult] 객체입니다.
  FilePickResult toDomain() {
    switch (permission) {
      case FilePermissionStatus.granted:
        return FilePickResult(path: path, isCancelled: isCancelled);
      case FilePermissionStatus.denied:
        return const FilePickResult(isDenied: true);
      case FilePermissionStatus.permanentlyDenied:
        return const FilePickResult(isPermanentlyDenied: true);
    }
  }
}
