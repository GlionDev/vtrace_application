/// 네트워크 관련 에러를 나타내는 예외 클래스입니다.
///
/// API 호출 실패 시 Repository 에서 이 예외를 던집니다.
class NetworkException implements Exception {
  /// 에러 상세 메시지
  final String message;

  /// HTTP 상태 코드 (선택값)
  final int? statusCode;

  /// [NetworkException] 객체를 생성합니다.
  ///
  /// [message] 에러를 설명하는 메시지
  /// [statusCode] 응답으로 받은 HTTP 상태 코드 (기본값: null)
  NetworkException(this.message, [this.statusCode]);

  @override
  String toString() => 'NetworkException: $message (statusCode: $statusCode)';
}
