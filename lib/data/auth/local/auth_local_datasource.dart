/// 인증 관련 로컬(SharedPreferences + SecureStorage) 접근을 추상화한 데이터소스입니다.
abstract class AuthLocalDataSource {
  /// 자동 로그인 사용 여부와 마지막 이메일을 저장합니다.
  ///
  /// [rememberMe] 자동 로그인 사용 여부
  /// [email] 저장할 이메일 (rememberMe 가 true 일 때 의미가 있음)
  Future<void> saveRememberMe({
    required bool rememberMe,
    required String email,
  });

  /// 자동 로그인 사용 여부를 조회합니다.
  ///
  /// 반환값은 자동 로그인 활성화 여부입니다.
  Future<bool> getRememberMe();

  /// 마지막 로그인 이메일을 조회합니다.
  ///
  /// 반환값은 저장된 이메일 또는 null 입니다.
  Future<String?> getLastLoginEmail();

  /// 액세스 토큰을 안전하게 저장합니다.
  ///
  /// [token] 저장할 토큰 문자열
  Future<void> saveAccessToken(String token);

  /// 저장된 액세스 토큰을 조회합니다.
  ///
  /// 반환값은 저장된 토큰 또는 null 입니다.
  Future<String?> getAccessToken();

  /// 저장된 인증 정보를 모두 제거합니다.
  Future<void> clear();
}
