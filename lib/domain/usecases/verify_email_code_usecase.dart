import '../repositories/auth_repository.dart';

/// 이메일 인증 코드 검증 UseCase 입니다.
class VerifyEmailCodeUseCase {
  final AuthRepository _repository;

  /// [VerifyEmailCodeUseCase] 객체를 생성합니다.
  ///
  /// [repository] 인증 처리를 위임할 리포지토리
  const VerifyEmailCodeUseCase(this._repository);

  /// 입력된 인증 코드를 검증합니다.
  ///
  /// [email] 인증 대상 이메일
  /// [code] 입력된 인증 코드
  /// 반환값은 검증 성공 여부입니다.
  Future<bool> call({required String email, required String code}) {
    return _repository.verifyEmailCode(email: email, code: code);
  }
}
