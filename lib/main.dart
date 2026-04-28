import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/common/logger/app_logger.dart';
import 'core/design_system/theme/app_theme.dart';
import 'core/notification/di/notification_module.dart';
import 'router/app_router.dart';

/// 앱 진입점입니다.
///
/// 로거 초기화 및 [ProviderScope] 를 통한 Riverpod 컨테이너 구성을 수행합니다.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppLogger.init();

  runApp(const ProviderScope(child: MyApp()));
}

/// 앱 루트 위젯입니다.
class MyApp extends ConsumerWidget {
  /// [MyApp] 위젯을 생성합니다.
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 공유 인텐트 서비스를 미리 초기화하여 백그라운드 스트림 구독을 시작합니다.
    ref.watch(sharingIntentServiceProvider);

    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'VTrace',
      theme: AppTheme.light(),
      routerConfig: router,
    );
  }
}
