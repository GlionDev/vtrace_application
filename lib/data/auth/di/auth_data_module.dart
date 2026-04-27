import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/di/network_module.dart';
import '../../../core/secure_storage/di/secure_storage_module.dart';
import '../../../core/shared_pref/di/shared_pref_module.dart';
import '../../../domain/repositories/auth_repository.dart';
import '../auth_repository_impl.dart';
import '../local/auth_local_datasource.dart';
import '../local/auth_local_datasource_impl.dart';
import '../remote/api/auth_api_service.dart';
import '../remote/auth_remote_datasource.dart';
import '../remote/auth_remote_datasource_impl.dart';

part 'auth_data_module.g.dart';

/// 인증 API 서비스를 제공합니다.
///
/// 반환값은 Dio 인스턴스로 구성된 [AuthApiService] 입니다.
@Riverpod(keepAlive: true)
AuthApiService authApiService(Ref ref) {
  final dio = ref.watch(dioProvider);
  return AuthApiService(dio);
}

/// 인증 원격 데이터소스를 제공합니다.
///
/// 반환값은 [AuthRemoteDataSource] 의 구현 인스턴스입니다.
@Riverpod(keepAlive: true)
AuthRemoteDataSource authRemoteDataSource(Ref ref) {
  return AuthRemoteDataSourceImpl(ref.watch(authApiServiceProvider));
}

/// 인증 로컬 데이터소스를 제공합니다.
///
/// 반환값은 [AuthLocalDataSource] 의 구현 인스턴스입니다.
@Riverpod(keepAlive: true)
Future<AuthLocalDataSource> authLocalDataSource(Ref ref) async {
  final prefs = await ref.watch(sharedPreferencesProvider.future);
  final secure = ref.watch(secureStorageProvider);
  return AuthLocalDataSourceImpl(prefs: prefs, secureStorage: secure);
}

/// 인증 리포지토리를 제공합니다.
///
/// 반환값은 [AuthRepository] 의 구현 인스턴스입니다.
@Riverpod(keepAlive: true)
Future<AuthRepository> authRepository(Ref ref) async {
  final remote = ref.watch(authRemoteDataSourceProvider);
  final local = await ref.watch(authLocalDataSourceProvider.future);
  return AuthRepositoryImpl(remote: remote, local: local);
}
