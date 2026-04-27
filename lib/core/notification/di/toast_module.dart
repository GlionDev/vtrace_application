import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../toast_service.dart';

part 'toast_module.g.dart';

/// 앱 전역에서 사용할 [ToastService] 인스턴스를 제공합니다.
///
/// 반환값은 토스트 메시지 출력을 담당하는 서비스 객체입니다.
@Riverpod(keepAlive: true)
ToastService toastService(Ref ref) {
  return ToastService();
}
