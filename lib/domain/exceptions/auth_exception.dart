/// 인증 관련 도메인 예외의 최상위 타입입니다.
sealed class AuthException implements Exception {
  /// 사용자에게 노출할 수 있는 메시지
  final String message;

  /// [AuthException] 객체를 생성합니다.
  ///
  /// [message] 예외 상황을 설명하는 메시지
  const AuthException(this.message);

  @override
  String toString() => message;
}

/// 이메일/비밀번호 조합이 일치하지 않을 때 발생하는 예외입니다.
class InvalidCredentialsException extends AuthException {
  /// [InvalidCredentialsException] 객체를 생성합니다.
  ///
  /// [message] 에러 메시지 (기본값 제공)
  const InvalidCredentialsException([
    super.message = '이메일 혹은 비밀번호가 일치하지 않습니다.',
  ]);
}

/// 이메일 인증 코드가 일치하지 않을 때 발생하는 예외입니다.
class InvalidVerificationCodeException extends AuthException {
  /// [InvalidVerificationCodeException] 객체를 생성합니다.
  ///
  /// [message] 에러 메시지 (기본값 제공)
  const InvalidVerificationCodeException([
    super.message = '인증 코드가 올바르지 않습니다.',
  ]);
}

/// 그 외 인증 처리 도중 발생하는 알 수 없는 예외입니다.
class UnknownAuthException extends AuthException {
  /// [UnknownAuthException] 객체를 생성합니다.
  ///
  /// [message] 에러 메시지
  const UnknownAuthException(super.message);
}
