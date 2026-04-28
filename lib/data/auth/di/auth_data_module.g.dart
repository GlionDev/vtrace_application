// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_data_module.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 인증 API 서비스를 제공합니다.
///
/// 반환값은 Dio 인스턴스로 구성된 [AuthApiService] 입니다.

@ProviderFor(authApiService)
final authApiServiceProvider = AuthApiServiceProvider._();

/// 인증 API 서비스를 제공합니다.
///
/// 반환값은 Dio 인스턴스로 구성된 [AuthApiService] 입니다.

final class AuthApiServiceProvider
    extends $FunctionalProvider<AuthApiService, AuthApiService, AuthApiService>
    with $Provider<AuthApiService> {
  /// 인증 API 서비스를 제공합니다.
  ///
  /// 반환값은 Dio 인스턴스로 구성된 [AuthApiService] 입니다.
  AuthApiServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authApiServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authApiServiceHash();

  @$internal
  @override
  $ProviderElement<AuthApiService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AuthApiService create(Ref ref) {
    return authApiService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthApiService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthApiService>(value),
    );
  }
}

String _$authApiServiceHash() => r'2842df92adc1b0419952c1eb02955ef80515fa36';

/// 인증 원격 데이터소스를 제공합니다.
///
/// 반환값은 [AuthRemoteDataSource] 의 구현 인스턴스입니다.

@ProviderFor(authRemoteDataSource)
final authRemoteDataSourceProvider = AuthRemoteDataSourceProvider._();

/// 인증 원격 데이터소스를 제공합니다.
///
/// 반환값은 [AuthRemoteDataSource] 의 구현 인스턴스입니다.

final class AuthRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          AuthRemoteDataSource,
          AuthRemoteDataSource,
          AuthRemoteDataSource
        >
    with $Provider<AuthRemoteDataSource> {
  /// 인증 원격 데이터소스를 제공합니다.
  ///
  /// 반환값은 [AuthRemoteDataSource] 의 구현 인스턴스입니다.
  AuthRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authRemoteDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<AuthRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AuthRemoteDataSource create(Ref ref) {
    return authRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthRemoteDataSource>(value),
    );
  }
}

String _$authRemoteDataSourceHash() =>
    r'526be47417229eaee77422ce8b32221c1ec7b730';

/// 인증 로컬 데이터소스를 제공합니다.
///
/// 반환값은 [AuthLocalDataSource] 의 구현 인스턴스입니다.

@ProviderFor(authLocalDataSource)
final authLocalDataSourceProvider = AuthLocalDataSourceProvider._();

/// 인증 로컬 데이터소스를 제공합니다.
///
/// 반환값은 [AuthLocalDataSource] 의 구현 인스턴스입니다.

final class AuthLocalDataSourceProvider
    extends
        $FunctionalProvider<
          AsyncValue<AuthLocalDataSource>,
          AuthLocalDataSource,
          FutureOr<AuthLocalDataSource>
        >
    with
        $FutureModifier<AuthLocalDataSource>,
        $FutureProvider<AuthLocalDataSource> {
  /// 인증 로컬 데이터소스를 제공합니다.
  ///
  /// 반환값은 [AuthLocalDataSource] 의 구현 인스턴스입니다.
  AuthLocalDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authLocalDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authLocalDataSourceHash();

  @$internal
  @override
  $FutureProviderElement<AuthLocalDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<AuthLocalDataSource> create(Ref ref) {
    return authLocalDataSource(ref);
  }
}

String _$authLocalDataSourceHash() =>
    r'a1079996d518acd403b71d6ca970d146a3ae3e36';

/// 인증 리포지토리를 제공합니다.
///
/// 반환값은 [AuthRepository] 의 구현 인스턴스입니다.

@ProviderFor(authRepository)
final authRepositoryProvider = AuthRepositoryProvider._();

/// 인증 리포지토리를 제공합니다.
///
/// 반환값은 [AuthRepository] 의 구현 인스턴스입니다.

final class AuthRepositoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<AuthRepository>,
          AuthRepository,
          FutureOr<AuthRepository>
        >
    with $FutureModifier<AuthRepository>, $FutureProvider<AuthRepository> {
  /// 인증 리포지토리를 제공합니다.
  ///
  /// 반환값은 [AuthRepository] 의 구현 인스턴스입니다.
  AuthRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authRepositoryHash();

  @$internal
  @override
  $FutureProviderElement<AuthRepository> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<AuthRepository> create(Ref ref) {
    return authRepository(ref);
  }
}

String _$authRepositoryHash() => r'f420830200cd0357e07faa6f1d00234001b7d3bc';
