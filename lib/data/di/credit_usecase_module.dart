import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/usecases/fetch_credit_products_usecase.dart';
import '../../domain/usecases/observe_purchase_status_usecase.dart';
import '../../domain/usecases/purchase_credit_usecase.dart';
import '../credit/di/credit_data_module.dart';

part 'credit_usecase_module.g.dart';

/// 크레딧 상품 조회 UseCase 를 제공합니다.
///
/// 반환값은 [FetchCreditProductsUseCase] 인스턴스입니다.
@Riverpod(keepAlive: true)
FetchCreditProductsUseCase fetchCreditProductsUseCase(Ref ref) {
  return FetchCreditProductsUseCase(ref.watch(creditRepositoryProvider));
}

/// 크레딧 결제 요청 UseCase 를 제공합니다.
///
/// 반환값은 [PurchaseCreditUseCase] 인스턴스입니다.
@Riverpod(keepAlive: true)
PurchaseCreditUseCase purchaseCreditUseCase(Ref ref) {
  return PurchaseCreditUseCase(ref.watch(creditRepositoryProvider));
}

/// 결제 상태 구독 UseCase 를 제공합니다.
///
/// 반환값은 [ObservePurchaseStatusUseCase] 인스턴스입니다.
@Riverpod(keepAlive: true)
ObservePurchaseStatusUseCase observePurchaseStatusUseCase(Ref ref) {
  return ObservePurchaseStatusUseCase(ref.watch(creditRepositoryProvider));
}
