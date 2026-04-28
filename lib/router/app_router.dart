import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../feature/auth/forgot_password/forgot_password_screen.dart';
import '../feature/auth/login/login_screen.dart';
import '../feature/auth/signup/signup_screen.dart';
import '../feature/home/home_screen.dart';
import '../feature/pay/pay_screen.dart';

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
      GoRoute(
        path: '/forgot-password',
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(path: '/pay', builder: (context, state) => const PayScreen()),
    ],
  );
}
