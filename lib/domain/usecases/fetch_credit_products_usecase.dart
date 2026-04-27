import '../models/credit_product.dart';
import '../repositories/credit_repository.dart';

/// 크레딧 상품 목록 조회 UseCase 입니다.
class FetchCreditProductsUseCase {
  final CreditRepository _repository;

  /// [FetchCreditProductsUseCase] 객체를 생성합니다.
  ///
  /// [repository] 결제 처리를 위임할 리포지토리
  const FetchCreditProductsUseCase(this._repository);

  /// 크레딧 상품 목록을 조회합니다.
  ///
  /// 반환값은 노출 가능한 [CreditProduct] 리스트입니다.
  Future<List<CreditProduct>> call() => _repository.fetchProducts();
}
