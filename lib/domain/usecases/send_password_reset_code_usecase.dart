import '../repositories/auth_repository.dart';

/// 비밀번호 재설정 코드 발송 UseCase 입니다.
class SendPasswordResetCodeUseCase {
  final AuthRepository _repository;

  /// [SendPasswordResetCodeUseCase] 객체를 생성합니다.
  ///
  /// [repository] 인증 처리를 위임할 리포지토리
  const SendPasswordResetCodeUseCase(this._repository);

  /// 지정한 이메일로 비밀번호 재설정 코드를 발송합니다.
  ///
  /// [email] 재설정 안내를 받을 이메일 주소
  Future<void> call({required String email}) {
    return _repository.sendPasswordResetCode(email: email);
  }
}
