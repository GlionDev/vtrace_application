import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:fluttertoast/fluttertoast.dart';

part 'pay_viewmodel.g.dart';

/// 결제 상품과 결제 상태를 관리하는 상태 클래스입니다.
class PayState {
  final String selectedProductId;
  final bool isLoading;

  const PayState({
    this.selectedProductId = 'token_1000', // 기본 선택값 1000원 상품
    this.isLoading = false,
  });

  PayState copyWith({String? selectedProductId, bool? isLoading}) {
    return PayState(
      selectedProductId: selectedProductId ?? this.selectedProductId,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

/// 결제 로직과 앱 결제 리스너를 처리하는 뷰모델입니다.
@riverpod
class PayViewModel extends _$PayViewModel {
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;

  @override
  PayState build() {
    _initStoreInfo();
    ref.onDispose(() {
      _subscription.cancel();
    });
    return const PayState();
  }

  /// 상품 선택 변경
  void selectProduct(String productId) {
    state = state.copyWith(selectedProductId: productId);
  }

  /// 인앱 결제 초기화 및 구독 설정
  void _initStoreInfo() {
    final Stream<List<PurchaseDetails>> purchaseUpdated =
        _inAppPurchase.purchaseStream;
    _subscription = purchaseUpdated.listen(
      (purchaseDetailsList) {
        _listenToPurchaseUpdated(purchaseDetailsList);
      },
      onDone: () {
        _subscription.cancel();
      },
      onError: (error) {
        Fluttertoast.showToast(msg: "결제 에러: $error");
        state = state.copyWith(isLoading: false);
      },
    );
  }

  /// 결제 결과를 처리하는 내부 메서드
  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    for (var purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        state = state.copyWith(isLoading: true);
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          Fluttertoast.showToast(
            msg: "결제 실패: ${purchaseDetails.error?.message}",
          );
        } else if (purchaseDetails.status == PurchaseStatus.purchased ||
            purchaseDetails.status == PurchaseStatus.restored) {
          Fluttertoast.showToast(msg: "결제 성공!");
          if (purchaseDetails.pendingCompletePurchase) {
            _inAppPurchase.completePurchase(purchaseDetails);
          }
        }
        state = state.copyWith(isLoading: false);
      }
    }
  }

  /// 구매하기 액션 수행
  Future<void> purchaseSelectedProduct() async {
    state = state.copyWith(isLoading: true);
    final bool isAvailable = await _inAppPurchase.isAvailable();
    if (!isAvailable) {
      Fluttertoast.showToast(msg: "지금은 스토어에 연결할 수 없습니다.");
      state = state.copyWith(isLoading: false);
      return;
    }

    Set<String> kIds = <String>{state.selectedProductId};
    final ProductDetailsResponse response = await _inAppPurchase
        .queryProductDetails(kIds);
    if (response.notFoundIDs.isNotEmpty) {
      Fluttertoast.showToast(msg: "등록되지 않은 상품입니다.");
      await Future.delayed(const Duration(seconds: 1));
      Fluttertoast.showToast(msg: "기기 결제 연결창 호스팅 중..");
      state = state.copyWith(isLoading: false);
      return;
    }

    final ProductDetails productDetails = response.productDetails.first;
    final PurchaseParam purchaseParam = PurchaseParam(
      productDetails: productDetails,
    );

    _inAppPurchase.buyConsumable(purchaseParam: purchaseParam);
  }
}
