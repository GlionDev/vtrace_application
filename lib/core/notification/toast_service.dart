import 'package:fluttertoast/fluttertoast.dart';

/// 토스트 메시지 출력을 추상화한 서비스입니다.
///
/// 위젯이 직접 [Fluttertoast] 를 호출하지 않도록 래핑하여
/// 추후 다른 토스트 구현체로의 교체를 용이하게 합니다.
class ToastService {
  /// 일반 정보용 토스트를 표시합니다.
  ///
  /// [message] 표시할 메시지 텍스트
  void showInfo(String message) {
    Fluttertoast.showToast(msg: message);
  }

  /// 에러 강조용 토스트를 표시합니다.
  ///
  /// [message] 표시할 에러 메시지 텍스트
  void showError(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }
}
