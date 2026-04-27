import '../models/credit_product.dart';

/// 크레딧(인앱 결제) 관련 도메인 동작을 정의하는 리포지토리 인터페이스입니다.
abstract class CreditRepository {
  /// 노출 가능한 크레딧 상품 목록을 조회합니다.
  ///
  /// 반환값은 [CreditProduct] 의 리스트입니다.
  Future<List<CreditProduct>> fetchProducts();

  /// 지정한 상품에 대한 결제를 요청합니다.
  ///
  /// [productId] 결제할 상품의 ID
  Future<void> purchase({required String productId});

  /// 결제 결과 이벤트를 노출하는 스트림을 반환합니다.
  ///
  /// 반환값은 결제 성공/실패/대기 등의 상태 변경을 알리는 [Stream] 입니다.
  Stream<CreditPurchaseStatus> purchaseUpdates();
}

/// 인앱 결제 상태 결과를 표현하는 도메인 값 객체입니다.
enum CreditPurchaseStatus {
  /// 결제 진행 중
  pending,

  /// 결제 성공
  success,

  /// 결제 실패
  failure,
}
