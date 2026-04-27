import '../repositories/credit_repository.dart';

/// 크레딧 상품 결제를 수행하는 UseCase 입니다.
class PurchaseCreditUseCase {
  final CreditRepository _repository;

  /// [PurchaseCreditUseCase] 객체를 생성합니다.
  ///
  /// [repository] 결제 처리를 위임할 리포지토리
  const PurchaseCreditUseCase(this._repository);

  /// 지정한 상품에 대한 결제를 요청합니다.
  ///
  /// [productId] 결제할 상품의 ID
  Future<void> call({required String productId}) {
    return _repository.purchase(productId: productId);
  }
}
