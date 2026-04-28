import '../../domain/models/credit_product.dart';

/// 결제 화면의 진행 상태를 나타냅니다.
enum PayStatus {
  /// 대기 상태(별도 알림 없음)
  idle,

  /// 결제 흐름 시작 안내 필요
  hostingStarted,

  /// 결제 성공
  success,

  /// 결제 실패
  failure,
}

/// 결제 화면의 결제 상품 정보 및 결제 상태를 관리하는 상태 클래스입니다.
class PayState {
  /// 노출 가능한 결제 상품 목록
  final List<CreditProduct> products;

  /// 현재 선택된 결제 상품 ID
  final String selectedProductId;

  /// 결제 진행(로딩) 여부
  final bool isLoading;

  /// 결제 흐름 상태
  final PayStatus status;

  /// 사용자에게 노출할 메시지(toast 등에 사용)
  final String? message;

  /// [PayState] 객체를 생성합니다.
  const PayState({
    this.products = const [],
    this.selectedProductId = 'token_1000',
    this.isLoading = false,
    this.status = PayStatus.idle,
    this.message,
  });

  /// 기존 상태를 복사하여 일부 값만 변경한 새로운 인스턴스를 반환합니다.
  ///
  /// [clearMessage] 가 true 이면 [message] 를 null 로 초기화합니다.
  /// 반환값은 새로 생성된 [PayState] 객체입니다.
  PayState copyWith({
    List<CreditProduct>? products,
    String? selectedProductId,
    bool? isLoading,
    PayStatus? status,
    String? message,
    bool clearMessage = false,
  }) {
    return PayState(
      products: products ?? this.products,
      selectedProductId: selectedProductId ?? this.selectedProductId,
      isLoading: isLoading ?? this.isLoading,
      status: status ?? this.status,
      message: clearMessage ? null : (message ?? this.message),
    );
  }
}
