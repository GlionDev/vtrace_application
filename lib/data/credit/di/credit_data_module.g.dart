// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credit_data_module.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 인앱결제 SDK 인스턴스를 제공합니다.
///
/// 반환값은 전역 [InAppPurchase] 인스턴스입니다.

@ProviderFor(inAppPurchase)
final inAppPurchaseProvider = InAppPurchaseProvider._();

/// 인앱결제 SDK 인스턴스를 제공합니다.
///
/// 반환값은 전역 [InAppPurchase] 인스턴스입니다.

final class InAppPurchaseProvider
    extends $FunctionalProvider<InAppPurchase, InAppPurchase, InAppPurchase>
    with $Provider<InAppPurchase> {
  /// 인앱결제 SDK 인스턴스를 제공합니다.
  ///
  /// 반환값은 전역 [InAppPurchase] 인스턴스입니다.
  InAppPurchaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'inAppPurchaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$inAppPurchaseHash();

  @$internal
  @override
  $ProviderElement<InAppPurchase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  InAppPurchase create(Ref ref) {
    return inAppPurchase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(InAppPurchase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<InAppPurchase>(value),
    );
  }
}

String _$inAppPurchaseHash() => r'fb3c7e600ea6835241b4be249fabfd992de703ff';

/// 결제 원격 데이터소스를 제공합니다.
///
/// 반환값은 [CreditRemoteDataSource] 의 구현 인스턴스입니다.

@ProviderFor(creditRemoteDataSource)
final creditRemoteDataSourceProvider = CreditRemoteDataSourceProvider._();

/// 결제 원격 데이터소스를 제공합니다.
///
/// 반환값은 [CreditRemoteDataSource] 의 구현 인스턴스입니다.

final class CreditRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          CreditRemoteDataSource,
          CreditRemoteDataSource,
          CreditRemoteDataSource
        >
    with $Provider<CreditRemoteDataSource> {
  /// 결제 원격 데이터소스를 제공합니다.
  ///
  /// 반환값은 [CreditRemoteDataSource] 의 구현 인스턴스입니다.
  CreditRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'creditRemoteDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$creditRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<CreditRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CreditRemoteDataSource create(Ref ref) {
    return creditRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CreditRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CreditRemoteDataSource>(value),
    );
  }
}

String _$creditRemoteDataSourceHash() =>
    r'2ebab1ad1c549b23a24b2a5576fe3c6479553bda';

/// 결제 리포지토리를 제공합니다.
///
/// 반환값은 [CreditRepository] 의 구현 인스턴스입니다.

@ProviderFor(creditRepository)
final creditRepositoryProvider = CreditRepositoryProvider._();

/// 결제 리포지토리를 제공합니다.
///
/// 반환값은 [CreditRepository] 의 구현 인스턴스입니다.

final class CreditRepositoryProvider
    extends
        $FunctionalProvider<
          CreditRepository,
          CreditRepository,
          CreditRepository
        >
    with $Provider<CreditRepository> {
  /// 결제 리포지토리를 제공합니다.
  ///
  /// 반환값은 [CreditRepository] 의 구현 인스턴스입니다.
  CreditRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'creditRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$creditRepositoryHash();

  @$internal
  @override
  $ProviderElement<CreditRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CreditRepository create(Ref ref) {
    return creditRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CreditRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CreditRepository>(value),
    );
  }
}

String _$creditRepositoryHash() => r'3cd701b292a86d402f107c1875a19449ce4e1af8';
