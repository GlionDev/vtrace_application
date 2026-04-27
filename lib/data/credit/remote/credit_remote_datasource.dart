import '../../../domain/models/credit_product.dart';
import 'dto/purchase_status_dto.dart';

/// 인앱 결제 외부 호출(스토어 SDK) 을 추상화한 데이터소스입니다.
abstract class CreditRemoteDataSource {
  /// 결제 가능한 상품 목록을 조회합니다.
  ///
  /// 반환값은 [CreditProduct] 리스트입니다.
  Future<List<CreditProduct>> fetchProducts();

  /// 지정한 상품에 대한 결제를 요청합니다.
  ///
  /// [productId] 결제할 상품 ID
  Future<void> purchase({required String productId});

  /// 결제 결과 이벤트 스트림을 반환합니다.
  ///
  /// 반환값은 결제 상태 DTO 를 발행하는 [Stream] 입니다.
  Stream<PurchaseStatusDto> purchaseUpdates();
}
