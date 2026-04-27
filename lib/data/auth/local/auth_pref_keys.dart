/// 인증 관련 [SharedPreferences] 키 모음입니다.
class AuthPrefKeys {
  AuthPrefKeys._();

  /// 자동 로그인 여부 저장 키
  static const String rememberMe = 'auth.remember_me';

  /// 마지막 로그인한 이메일 저장 키
  static const String lastLoginEmail = 'auth.last_login_email';
}

/// 인증 토큰 저장에 사용하는 [FlutterSecureStorage] 키 모음입니다.
class AuthSecureKeys {
  AuthSecureKeys._();

  /// 액세스 토큰 키
  static const String accessToken = 'auth.access_token';
}
