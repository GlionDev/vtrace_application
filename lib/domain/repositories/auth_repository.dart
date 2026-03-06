import '../models/auth_user.dart';

/// 앱 인증 처리를 담당하는 레포지토리 인터페이스입니다.
abstract class AuthRepository {
  /// 사용자 로그인을 수행합니다.
  ///
  /// [email] 입력받은 사용자 이메일
  /// [password] 입력받은 사용자 비밀번호
  /// 반환값은 로그인 성공 시 얻은 [AuthUser] 객체입니다.
  Future<AuthUser> login(String email, String password);

  /// 사용자 회원가입을 수행합니다.
  ///
  /// [email] 가입할 이메일
  /// [code] 이메일 인증코드
  /// [password] 설정할 비밀번호
  /// 반환값은 가입 성공 시 얻은 [AuthUser] 객체입니다.
  Future<AuthUser> register(String email, String code, String password);
}
