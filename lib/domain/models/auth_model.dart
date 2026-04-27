/// 사용자 인증 정보를 담는 도메인 모델입니다.
class AuthUser {
  /// 사용자의 고유 ID
  final String id;

  /// 사용자의 이메일 주소
  final String email;

  /// 발급받은 액세스 토큰
  final String token;

  /// [AuthUser] 객체를 생성합니다.
  ///
  /// [id] 사용자 고유 식별자
  /// [email] 사용자 이메일
  /// [token] 발급된 액세스 토큰
  const AuthUser({
    required this.id,
    required this.email,
    required this.token,
  });
}
