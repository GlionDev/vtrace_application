import '../../../domain/exceptions/auth_exception.dart';
import 'api/auth_api_service.dart';
import 'auth_remote_datasource.dart';
import 'dto/auth_response_dto.dart';

/// [AuthRemoteDataSource] 의 mock 구현체입니다.
///
/// 백엔드 API 명세 확정 시 [AuthApiService] 호출로 본문을 교체합니다.
/// 현재는 인위적인 딜레이와 고정 검증값으로 동작합니다.
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  // ignore: unused_field
  final AuthApiService _apiService;

  /// [AuthRemoteDataSourceImpl] 객체를 생성합니다.
  ///
  /// [apiService] 실제 호출에 사용할 API 서비스 (현재 mock 구현에서는 미사용)
  const AuthRemoteDataSourceImpl(this._apiService);

  @override
  Future<AuthResponseDto> login({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(milliseconds: 1500));
    if (email != 'T@T' || password != 'aA1!') {
      throw const InvalidCredentialsException();
    }
    return AuthResponseDto(
      id: 'mock_id_1',
      email: email,
      token: 'mock_token_abc',
    );
  }

  @override
  Future<AuthResponseDto> register({
    required String email,
    required String code,
    required String password,
  }) async {
    await Future.delayed(const Duration(milliseconds: 1500));
    if (code != '1234') {
      throw const InvalidVerificationCodeException();
    }
    return AuthResponseDto(
      id: 'mock_id_register',
      email: email,
      token: 'mock_token_xyz',
    );
  }

  @override
  Future<void> sendEmailVerificationCode({required String email}) async {
    await Future.delayed(const Duration(milliseconds: 300));
  }

  @override
  Future<bool> verifyEmailCode({
    required String email,
    required String code,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return code == '1234';
  }

  @override
  Future<void> sendPasswordResetCode({required String email}) async {
    await Future.delayed(const Duration(seconds: 2));
  }
}
