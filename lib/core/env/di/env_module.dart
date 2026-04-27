import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../app_env.dart';

part 'env_module.g.dart';

/// 현재 빌드 환경에 해당하는 [AppEnv] 인스턴스를 제공합니다.
///
/// `--dart-define=FLAVOR=...` 로 주입된 값에 따라 dev/staging/prod 중 하나가 반환됩니다.
/// 반환값은 환경별 설정값이 담긴 [AppEnv] 객체입니다.
@Riverpod(keepAlive: true)
AppEnv appEnv(Ref ref) {
  return AppEnv.current();
}
