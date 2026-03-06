/// 사용자 인증 정보를 담는 비즈니스 모델입니다.
class AuthUser {
  /// 사용자의 고유 ID
  final String id;

  /// 사용자의 이메일 주소
  final String email;

  /// 발급받은 엑세스 토큰
  final String token;

  /// [AuthUser] 객체를 생성합니다.
  AuthUser({required this.id, required this.email, required this.token});
}
