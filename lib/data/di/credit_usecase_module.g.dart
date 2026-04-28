// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credit_usecase_module.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 크레딧 상품 조회 UseCase 를 제공합니다.
///
/// 반환값은 [FetchCreditProductsUseCase] 인스턴스입니다.

@ProviderFor(fetchCreditProductsUseCase)
final fetchCreditProductsUseCaseProvider =
    FetchCreditProductsUseCaseProvider._();

/// 크레딧 상품 조회 UseCase 를 제공합니다.
///
/// 반환값은 [FetchCreditProductsUseCase] 인스턴스입니다.

final class FetchCreditProductsUseCaseProvider
    extends
        $FunctionalProvider<
          FetchCreditProductsUseCase,
          FetchCreditProductsUseCase,
          FetchCreditProductsUseCase
        >
    with $Provider<FetchCreditProductsUseCase> {
  /// 크레딧 상품 조회 UseCase 를 제공합니다.
  ///
  /// 반환값은 [FetchCreditProductsUseCase] 인스턴스입니다.
  FetchCreditProductsUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fetchCreditProductsUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fetchCreditProductsUseCaseHash();

  @$internal
  @override
  $ProviderElement<FetchCreditProductsUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FetchCreditProductsUseCase create(Ref ref) {
    return fetchCreditProductsUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FetchCreditProductsUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FetchCreditProductsUseCase>(value),
    );
  }
}

String _$fetchCreditProductsUseCaseHash() =>
    r'061a98c693b68d38b5f89497c148c691d0082dc1';

/// 크레딧 결제 요청 UseCase 를 제공합니다.
///
/// 반환값은 [PurchaseCreditUseCase] 인스턴스입니다.

@ProviderFor(purchaseCreditUseCase)
final purchaseCreditUseCaseProvider = PurchaseCreditUseCaseProvider._();

/// 크레딧 결제 요청 UseCase 를 제공합니다.
///
/// 반환값은 [PurchaseCreditUseCase] 인스턴스입니다.

final class PurchaseCreditUseCaseProvider
    extends
        $FunctionalProvider<
          PurchaseCreditUseCase,
          PurchaseCreditUseCase,
          PurchaseCreditUseCase
        >
    with $Provider<PurchaseCreditUseCase> {
  /// 크레딧 결제 요청 UseCase 를 제공합니다.
  ///
  /// 반환값은 [PurchaseCreditUseCase] 인스턴스입니다.
  PurchaseCreditUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'purchaseCreditUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$purchaseCreditUseCaseHash();

  @$internal
  @override
  $ProviderElement<PurchaseCreditUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PurchaseCreditUseCase create(Ref ref) {
    return purchaseCreditUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PurchaseCreditUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PurchaseCreditUseCase>(value),
    );
  }
}

String _$purchaseCreditUseCaseHash() =>
    r'd5b4c8d9c6f1506a4219c0f803fdab990c93864b';

/// 결제 상태 구독 UseCase 를 제공합니다.
///
/// 반환값은 [ObservePurchaseStatusUseCase] 인스턴스입니다.

@ProviderFor(observePurchaseStatusUseCase)
final observePurchaseStatusUseCaseProvider =
    ObservePurchaseStatusUseCaseProvider._();

/// 결제 상태 구독 UseCase 를 제공합니다.
///
/// 반환값은 [ObservePurchaseStatusUseCase] 인스턴스입니다.

final class ObservePurchaseStatusUseCaseProvider
    extends
        $FunctionalProvider<
          ObservePurchaseStatusUseCase,
          ObservePurchaseStatusUseCase,
          ObservePurchaseStatusUseCase
        >
    with $Provider<ObservePurchaseStatusUseCase> {
  /// 결제 상태 구독 UseCase 를 제공합니다.
  ///
  /// 반환값은 [ObservePurchaseStatusUseCase] 인스턴스입니다.
  ObservePurchaseStatusUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'observePurchaseStatusUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$observePurchaseStatusUseCaseHash();

  @$internal
  @override
  $ProviderElement<ObservePurchaseStatusUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ObservePurchaseStatusUseCase create(Ref ref) {
    return observePurchaseStatusUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ObservePurchaseStatusUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ObservePurchaseStatusUseCase>(value),
    );
  }
}

String _$observePurchaseStatusUseCaseHash() =>
    r'260ae8720de831fbe32dffdf0038a802903cc857';
