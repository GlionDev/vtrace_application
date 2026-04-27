import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/repositories/credit_repository.dart';
import '../credit_repository_impl.dart';
import '../remote/credit_remote_datasource.dart';
import '../remote/credit_remote_datasource_impl.dart';

part 'credit_data_module.g.dart';

/// 인앱결제 SDK 인스턴스를 제공합니다.
///
/// 반환값은 전역 [InAppPurchase] 인스턴스입니다.
@Riverpod(keepAlive: true)
InAppPurchase inAppPurchase(Ref ref) {
  return InAppPurchase.instance;
}

/// 결제 원격 데이터소스를 제공합니다.
///
/// 반환값은 [CreditRemoteDataSource] 의 구현 인스턴스입니다.
@Riverpod(keepAlive: true)
CreditRemoteDataSource creditRemoteDataSource(Ref ref) {
  return CreditRemoteDataSourceImpl(ref.watch(inAppPurchaseProvider));
}

/// 결제 리포지토리를 제공합니다.
///
/// 반환값은 [CreditRepository] 의 구현 인스턴스입니다.
@Riverpod(keepAlive: true)
CreditRepository creditRepository(Ref ref) {
  return CreditRepositoryImpl(ref.watch(creditRemoteDataSourceProvider));
}
