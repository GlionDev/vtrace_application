import '../../domain/models/auth_model.dart';
import '../../domain/repositories/auth_repository.dart';
import '../mappers/auth_mapper.dart';
import 'local/auth_local_datasource.dart';
import 'remote/auth_remote_datasource.dart';

/// [AuthRepository] 의 구현체입니다.
///
/// 원격 데이터소스의 응답 DTO 를 도메인 모델로 변환하고,
/// 필요 시 로컬 데이터소스에 토큰/자동로그인 정보를 저장합니다.
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remote;
  final AuthLocalDataSource _local;

  /// [AuthRepositoryImpl] 객체를 생성합니다.
  ///
  /// [remote] 인증 원격 데이터소스
  /// [local] 인증 로컬 데이터소스
  const AuthRepositoryImpl({
    required AuthRemoteDataSource remote,
    required AuthLocalDataSource local,
  }) : _remote = remote,
       _local = local;

  @override
  Future<AuthUser> login({
    required String email,
    required String password,
  }) async {
    final dto = await _remote.login(email: email, password: password);
    final user = dto.toDomain();
    await _local.saveAccessToken(user.token);
    return user;
  }

  @override
  Future<AuthUser> register({
    required String email,
    required String code,
    required String password,
  }) async {
    final dto = await _remote.register(
      email: email,
      code: code,
      password: password,
    );
    final user = dto.toDomain();
    await _local.saveAccessToken(user.token);
    return user;
  }

  @override
  Future<void> sendEmailVerificationCode({required String email}) {
    return _remote.sendEmailVerificationCode(email: email);
  }

  @override
  Future<bool> verifyEmailCode({
    required String email,
    required String code,
  }) {
    return _remote.verifyEmailCode(email: email, code: code);
  }

  @override
  Future<void> sendPasswordResetCode({required String email}) {
    return _remote.sendPasswordResetCode(email: email);
  }
}
