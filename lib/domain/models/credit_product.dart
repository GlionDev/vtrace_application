/// 결제 가능한 크레딧 상품을 나타내는 도메인 모델입니다.
class CreditProduct {
  /// 스토어에 등록된 상품 ID
  final String id;

  /// 상품 표기명
  final String title;

  /// 가격 표기 문자열 (예: "1000원")
  final String priceLabel;

  /// 부가 설명 (예: "베스트")
  final String? badge;

  /// [CreditProduct] 객체를 생성합니다.
  ///
  /// [id] 상품 식별자
  /// [title] 상품 이름
  /// [priceLabel] 가격 표기 문자열
  /// [badge] 옵션 라벨
  const CreditProduct({
    required this.id,
    required this.title,
    required this.priceLabel,
    this.badge,
  });
}
