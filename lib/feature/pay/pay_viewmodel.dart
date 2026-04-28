import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/di/credit_usecase_module.dart';
import '../../domain/repositories/credit_repository.dart';
import 'pay_state.dart';

part 'pay_viewmodel.g.dart';

/// 결제 로직과 결제 상태 스트림을 처리하는 뷰모델입니다.
@riverpod
class PayViewModel extends _$PayViewModel {
  StreamSubscription<CreditPurchaseStatus>? _subscription;

  @override
  PayState build() {
    ref.onDispose(() {
      _subscription?.cancel();
    });
    _initialize();
    return const PayState();
  }

  Future<void> _initialize() async {
    try {
      final fetchUseCase = ref.read(fetchCreditProductsUseCaseProvider);
      final products = await fetchUseCase();
      state = state.copyWith(
        products: products,
        selectedProductId: products.isNotEmpty
            ? products.first.id
            : state.selectedProductId,
      );
    } catch (e) {
      state = state.copyWith(
        status: PayStatus.failure,
        message: '상품 정보를 불러오지 못했습니다.',
      );
    }

    final observeUseCase = ref.read(observePurchaseStatusUseCaseProvider);
    _subscription = observeUseCase().listen(_onPurchaseStatusChanged);
  }

  void _onPurchaseStatusChanged(CreditPurchaseStatus status) {
    switch (status) {
      case CreditPurchaseStatus.pending:
        state = state.copyWith(isLoading: true);
        break;
      case CreditPurchaseStatus.success:
        state = state.copyWith(
          isLoading: false,
          status: PayStatus.success,
          message: '결제 성공!',
        );
        break;
      case CreditPurchaseStatus.failure:
        state = state.copyWith(
          isLoading: false,
          status: PayStatus.failure,
          message: '결제 실패',
        );
        break;
    }
  }

  /// 사용자가 표시되는 메시지를 처리한 뒤 호출하여 상태를 초기화합니다.
  ///
  /// 동일한 메시지가 반복적으로 노출되지 않도록 합니다.
  void clearMessage() {
    state = state.copyWith(status: PayStatus.idle, clearMessage: true);
  }

  /// 결제 상품 선택을 변경합니다.
  ///
  /// [productId] 새로 선택된 상품 ID
  void selectProduct(String productId) {
    state = state.copyWith(selectedProductId: productId);
  }

  /// 현재 선택된 상품에 대한 결제를 요청합니다.
  Future<void> purchaseSelectedProduct() async {
    state = state.copyWith(
      isLoading: true,
      status: PayStatus.hostingStarted,
      message: '기기 결제 연결창 호스팅 중..',
    );

    try {
      final useCase = ref.read(purchaseCreditUseCaseProvider);
      await useCase(productId: state.selectedProductId);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        status: PayStatus.failure,
        message: e.toString(),
      );
    }
  }
}
