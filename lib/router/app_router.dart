import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../feature/home/presentation/widgets/home_screen.dart';
import '../feature/auth/presentation/widgets/login_screen.dart';
import '../feature/auth/presentation/widgets/signup_screen.dart';

part 'app_router.g.dart';

/// 앱 전반의 라우팅을 담당하는 [GoRouter] 객체를 제공합니다.
///
/// Riverpod을 통해 전역 관리되며, 앱의 네비게이션 트리와 초기 경로를 설정합니다.
@riverpod
GoRouter appRouter(Ref ref) {
  return GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
      GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: '/signup',
        builder: (context, state) => const SignUpScreen(),
      ),
    ],
  );
}
