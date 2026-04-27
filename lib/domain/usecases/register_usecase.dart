import '../models/auth_model.dart';
import '../repositories/auth_repository.dart';

/// 회원가입 비즈니스 로직을 캡슐화하는 UseCase 입니다.
class RegisterUseCase {
  final AuthRepository _repository;

  /// [RegisterUseCase] 객체를 생성합니다.
  ///
  /// [repository] 인증 처리를 위임할 리포지토리
  const RegisterUseCase(this._repository);

  /// 입력된 정보로 회원가입을 수행합니다.
  ///
  /// [email] 가입 이메일
  /// [code] 인증 코드
  /// [password] 설정할 비밀번호
  /// 반환값은 가입 성공 시 얻은 [AuthUser] 객체입니다.
  Future<AuthUser> call({
    required String email,
    required String code,
    required String password,
  }) {
    return _repository.register(
      email: email,
      code: code,
      password: password,
    );
  }
}
