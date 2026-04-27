import 'dto/auth_response_dto.dart';

/// 인증 관련 외부 API 호출을 추상화한 데이터소스입니다.
abstract class AuthRemoteDataSource {
  /// 로그인 API 호출 결과를 반환합니다.
  ///
  /// [email] 로그인 이메일
  /// [password] 로그인 비밀번호
  /// 반환값은 응답 DTO 입니다.
  Future<AuthResponseDto> login({
    required String email,
    required String password,
  });

  /// 회원가입 API 호출 결과를 반환합니다.
  ///
  /// [email] 가입 이메일
  /// [code] 인증 코드
  /// [password] 설정할 비밀번호
  /// 반환값은 응답 DTO 입니다.
  Future<AuthResponseDto> register({
    required String email,
    required String code,
    required String password,
  });

  /// 이메일 인증 코드 발송 API 를 호출합니다.
  ///
  /// [email] 코드를 받을 이메일
  Future<void> sendEmailVerificationCode({required String email});

  /// 이메일 인증 코드 검증 API 를 호출합니다.
  ///
  /// [email] 인증 대상 이메일
  /// [code] 입력된 인증 코드
  /// 반환값은 검증 성공 여부입니다.
  Future<bool> verifyEmailCode({
    required String email,
    required String code,
  });

  /// 비밀번호 재설정 코드 발송 API 를 호출합니다.
  ///
  /// [email] 재설정 안내를 받을 이메일
  Future<void> sendPasswordResetCode({required String email});
}
