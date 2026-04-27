import '../models/auth_model.dart';
import '../repositories/auth_repository.dart';

/// 로그인 비즈니스 로직을 캡슐화하는 UseCase 입니다.
class LoginUseCase {
  final AuthRepository _repository;

  /// [LoginUseCase] 객체를 생성합니다.
  ///
  /// [repository] 인증 처리를 위임할 리포지토리
  const LoginUseCase(this._repository);

  /// 입력된 자격 증명으로 로그인을 수행합니다.
  ///
  /// [email] 로그인 이메일
  /// [password] 로그인 비밀번호
  /// 반환값은 로그인 성공 시 얻은 [AuthUser] 객체입니다.
  Future<AuthUser> call({
    required String email,
    required String password,
  }) {
    return _repository.login(email: email, password: password);
  }
}
