import 'package:flutter/material.dart';

/// 앱 전반에서 사용하는 색상 토큰 모음입니다.
///
/// 위젯은 직접 색상 리터럴을 사용하지 않고 본 클래스를 통해 참조합니다.
class AppColor {
  AppColor._();

  /// 브랜드 메인 컬러
  static const Color primary = Colors.deepPurple;

  /// 일반 텍스트/배경 보조 색상
  static const Color textSecondary = Colors.grey;

  /// 입력 필드 비활성 테두리 색상
  static final Color inputBorder = Colors.grey.shade400;

  /// 에러 강조 색상
  static const Color error = Colors.red;

  /// 성공 상태 색상
  static const Color success = Colors.green;
}
