import '../../domain/models/credit_product.dart';
import '../../domain/repositories/credit_repository.dart';
import '../mappers/credit_mapper.dart';
import 'remote/credit_remote_datasource.dart';

/// [CreditRepository] 의 구현체입니다.
class CreditRepositoryImpl implements CreditRepository {
  final CreditRemoteDataSource _remote;

  /// [CreditRepositoryImpl] 객체를 생성합니다.
  ///
  /// [remote] 결제 처리 원격 데이터소스
  const CreditRepositoryImpl(this._remote);

  @override
  Future<List<CreditProduct>> fetchProducts() => _remote.fetchProducts();

  @override
  Future<void> purchase({required String productId}) {
    return _remote.purchase(productId: productId);
  }

  @override
  Stream<CreditPurchaseStatus> purchaseUpdates() {
    return _remote.purchaseUpdates().map((dto) => dto.toDomain());
  }
}
