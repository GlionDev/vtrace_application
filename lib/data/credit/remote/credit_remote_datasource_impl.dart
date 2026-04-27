import 'package:in_app_purchase/in_app_purchase.dart';

import '../../../domain/models/credit_product.dart';
import 'credit_remote_datasource.dart';
import 'dto/purchase_status_dto.dart';

/// [CreditRemoteDataSource] 의 [InAppPurchase] 기반 구현체입니다.
class CreditRemoteDataSourceImpl implements CreditRemoteDataSource {
  final InAppPurchase _inAppPurchase;

  /// [CreditRemoteDataSourceImpl] 객체를 생성합니다.
  ///
  /// [inAppPurchase] 결제 처리에 사용할 인앱결제 인스턴스
  CreditRemoteDataSourceImpl(this._inAppPurchase);

  /// 노출 가능한 정적 상품 목록입니다.
  static const List<CreditProduct> _catalog = [
    CreditProduct(id: 'token_1000', title: '10 Token', priceLabel: '1000원'),
    CreditProduct(
      id: 'token_3000',
      title: '35 Token',
      priceLabel: '3000원',
      badge: '베스트',
    ),
    CreditProduct(id: 'token_5000', title: '65 Token', priceLabel: '5000원'),
  ];

  @override
  Future<List<CreditProduct>> fetchProducts() async {
    return _catalog;
  }

  @override
  Future<void> purchase({required String productId}) async {
    final isAvailable = await _inAppPurchase.isAvailable();
    if (!isAvailable) {
      throw const _StoreUnavailable();
    }

    final response = await _inAppPurchase.queryProductDetails({productId});
    if (response.notFoundIDs.isNotEmpty) {
      throw const _ProductNotFound();
    }

    final productDetails = response.productDetails.first;
    final purchaseParam = PurchaseParam(productDetails: productDetails);
    await _inAppPurchase.buyConsumable(purchaseParam: purchaseParam);
  }

  @override
  Stream<PurchaseStatusDto> purchaseUpdates() {
    return _inAppPurchase.purchaseStream.expand((details) {
      return details.map((purchase) {
        if (purchase.status == PurchaseStatus.pending) {
          return PurchaseStatusDto.pending;
        }
        if (purchase.status == PurchaseStatus.purchased ||
            purchase.status == PurchaseStatus.restored) {
          if (purchase.pendingCompletePurchase) {
            _inAppPurchase.completePurchase(purchase);
          }
          return PurchaseStatusDto.success;
        }
        return PurchaseStatusDto.failure;
      });
    });
  }
}

class _StoreUnavailable implements Exception {
  const _StoreUnavailable();
  @override
  String toString() => '지금은 스토어에 연결할 수 없습니다.';
}

class _ProductNotFound implements Exception {
  const _ProductNotFound();
  @override
  String toString() => '등록되지 않은 상품입니다.';
}
