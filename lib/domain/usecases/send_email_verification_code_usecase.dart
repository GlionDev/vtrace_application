import '../repositories/auth_repository.dart';

/// 이메일 인증 코드 발송 UseCase 입니다.
class SendEmailVerificationCodeUseCase {
  final AuthRepository _repository;

  /// [SendEmailVerificationCodeUseCase] 객체를 생성합니다.
  ///
  /// [repository] 인증 처리를 위임할 리포지토리
  const SendEmailVerificationCodeUseCase(this._repository);

  /// 지정한 이메일로 인증 코드를 발송합니다.
  ///
  /// [email] 코드를 받을 이메일 주소
  Future<void> call({required String email}) {
    return _repository.sendEmailVerificationCode(email: email);
  }
}
