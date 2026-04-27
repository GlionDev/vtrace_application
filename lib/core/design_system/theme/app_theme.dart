import 'package:flutter/material.dart';

import '../color/app_color.dart';

/// 앱 전반에 적용되는 테마 정의 모음입니다.
class AppTheme {
  AppTheme._();

  /// 라이트 모드 [ThemeData] 를 반환합니다.
  ///
  /// 반환값은 [MaterialApp] 의 `theme` 인자에 직접 주입할 수 있습니다.
  static ThemeData light() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: AppColor.primary),
      useMaterial3: true,
    );
  }
}
