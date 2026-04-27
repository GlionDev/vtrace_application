import '../models/auth_model.dart';

/// 앱 인증 처리를 담당하는 레포지토리 인터페이스입니다.
abstract class AuthRepository {
  /// 사용자 로그인을 수행합니다.
  ///
  /// [email] 입력받은 사용자 이메일
  /// [password] 입력받은 사용자 비밀번호
  /// 반환값은 로그인 성공 시 얻은 [AuthUser] 객체입니다.
  Future<AuthUser> login({required String email, required String password});

  /// 사용자 회원가입을 수행합니다.
  ///
  /// [email] 가입할 이메일
  /// [code] 이메일 인증 코드
  /// [password] 설정할 비밀번호
  /// 반환값은 가입 성공 시 얻은 [AuthUser] 객체입니다.
  Future<AuthUser> register({
    required String email,
    required String code,
    required String password,
  });

  /// 회원가입 또는 비밀번호 찾기에 필요한 이메일 인증 코드를 발송합니다.
  ///
  /// [email] 코드를 받을 이메일 주소
  Future<void> sendEmailVerificationCode({required String email});

  /// 발송된 이메일 인증 코드를 검증합니다.
  ///
  /// [email] 인증 대상 이메일
  /// [code] 입력된 인증 코드
  /// 반환값은 검증 성공 여부입니다.
  Future<bool> verifyEmailCode({
    required String email,
    required String code,
  });

  /// 비밀번호 재설정용 코드를 발송합니다.
  ///
  /// [email] 재설정 안내를 받을 이메일 주소
  Future<void> sendPasswordResetCode({required String email});
}
