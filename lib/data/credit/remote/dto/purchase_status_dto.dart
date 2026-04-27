/// 인앱 결제 데이터소스가 노출하는 결제 상태 DTO 입니다.
enum PurchaseStatusDto {
  /// 결제 진행 중
  pending,

  /// 결제 성공
  success,

  /// 결제 실패
  failure,
}
