/// 파일 선택 시도의 결과를 나타내는 도메인 모델입니다.
class FilePickResult {
  /// 선택된 파일의 절대 경로 (성공이 아닐 경우 null)
  final String? path;

  /// 권한이 영구적으로 거부되었는지 여부
  final bool isPermanentlyDenied;

  /// 권한이 거부되었는지 여부
  final bool isDenied;

  /// 사용자가 선택을 취소했는지 여부
  final bool isCancelled;

  /// [FilePickResult] 객체를 생성합니다.
  ///
  /// [path] 선택된 파일 경로
  /// [isPermanentlyDenied] 권한 영구 거부 여부
  /// [isDenied] 권한 거부 여부
  /// [isCancelled] 사용자 취소 여부
  const FilePickResult({
    this.path,
    this.isPermanentlyDenied = false,
    this.isDenied = false,
    this.isCancelled = false,
  });

  /// 파일이 정상적으로 선택되었는지 여부를 반환합니다.
  bool get isSuccess => path != null;
}
