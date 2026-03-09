import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/models/auth_user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../core/network/exceptions/network_exception.dart';

part 'auth_repository_impl.g.dart';

/// 네트워크 통신없이 딜레이만으로 인증을 모의(Mock) 수행하는 레포지토리 구현체입니다.
///
/// 추후 백엔드 API 명세가 확정되면 내부를 ApiService 호출로 교체합니다.
class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<AuthUser> login(String email, String password) async {
    // 1.5초간 서버 통신을 시뮬레이션
    await Future.delayed(const Duration(milliseconds: 1500));

    // 정해진 테스트 계정 체크
    if (email != 'T@T' || password != 'aA1!') {
      throw NetworkException("이메일 혹은 비밀번호가 일치하지 않습니다.", 401);
    }

    return AuthUser(id: 'mock_id_1', email: email, token: 'mock_token_abc');
  }

  @override
  Future<AuthUser> register(String email, String code, String password) async {
    // 1.5초간 서버 통신을 시뮬레이션
    await Future.delayed(const Duration(milliseconds: 1500));

    if (code != '1234') {
      // 가상의 잘못된 인증코드 테스트
      throw NetworkException("인증 코드가 올바르지 않습니다.", 400);
    }

    return AuthUser(
      id: 'mock_id_register',
      email: email,
      token: 'mock_token_xyz',
    );
  }
}

/// Riverpod을 통해 제공되는 [AuthRepository] 인스턴스입니다.
@riverpod
AuthRepository authRepository(Ref ref) {
  return AuthRepositoryImpl();
}
