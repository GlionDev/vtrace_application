import 'package:logging/logging.dart';
import 'package:flutter/foundation.dart';

/// 앱 전역에서 사용할 로거 클래스입니다.
///
/// 로그 출력을 콘솔에 수행하도록 설정합니다.
class AppLogger {
  /// 로거 초기화를 수행하는 함수입니다.
  /// 앱 시작 시 호출되어 로그 포맷을 지정합니다.
  static void init() {
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((record) {
      if (kDebugMode) {
        print(
          '${record.level.name}: ${record.time}: [${record.loggerName}] ${record.message}',
        );
      }
    });
  }

  /// 특정 이름의 로거 객체를 반환합니다.
  ///
  /// [name] 로거의 이름 (주로 클래스명이나 모듈명 사용)
  /// 반환값은 지정된 이름의 [Logger] 객체입니다.
  static Logger getLogger(String name) {
    return Logger(name);
  }
}
