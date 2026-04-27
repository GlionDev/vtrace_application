import '../../domain/repositories/credit_repository.dart';
import '../credit/remote/dto/purchase_status_dto.dart';

/// [PurchaseStatusDto] ↔ 도메인 enum 매핑 확장입니다.
extension PurchaseStatusDtoMapper on PurchaseStatusDto {
  /// DTO 결제 상태를 도메인 [CreditPurchaseStatus] 로 변환합니다.
  ///
  /// 반환값은 변환된 도메인 결제 상태입니다.
  CreditPurchaseStatus toDomain() {
    switch (this) {
      case PurchaseStatusDto.pending:
        return CreditPurchaseStatus.pending;
      case PurchaseStatusDto.success:
        return CreditPurchaseStatus.success;
      case PurchaseStatusDto.failure:
        return CreditPurchaseStatus.failure;
    }
  }
}
