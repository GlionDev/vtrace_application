import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'shared_pref_module.g.dart';

/// 앱 전역에서 사용할 [SharedPreferences] 인스턴스를 제공합니다.
///
/// 각 데이터소스에서 비동기로 주입받아 키-값 저장소로 활용합니다.
/// 반환값은 초기화된 [SharedPreferences] 객체입니다.
@Riverpod(keepAlive: true)
Future<SharedPreferences> sharedPreferences(Ref ref) {
  return SharedPreferences.getInstance();
}
