import '../repositories/credit_repository.dart';

/// 결제 상태 변경 이벤트 스트림을 노출하는 UseCase 입니다.
class ObservePurchaseStatusUseCase {
  final CreditRepository _repository;

  /// [ObservePurchaseStatusUseCase] 객체를 생성합니다.
  ///
  /// [repository] 결제 처리를 위임할 리포지토리
  const ObservePurchaseStatusUseCase(this._repository);

  /// 결제 상태 스트림을 반환합니다.
  ///
  /// 반환값은 결제 상태 변경 이벤트를 발행하는 [Stream] 입니다.
  Stream<CreditPurchaseStatus> call() => _repository.purchaseUpdates();
}
