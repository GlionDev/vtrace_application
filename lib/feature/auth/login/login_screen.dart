import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/design_system/widgets/vtrace_button.dart';
import '../../../core/design_system/widgets/vtrace_textfield.dart';
import '../../../core/notification/di/toast_module.dart';
import 'login_viewmodel.dart';

/// 사용자가 로그인 정보를 입력하고 인증을 요청하는 로그인 화면 위젯입니다.
class LoginScreen extends ConsumerStatefulWidget {
  /// [LoginScreen] 위젯을 생성합니다.
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _attemptLogin() async {
    final viewModel = ref.read(loginViewModelProvider.notifier);
    final user = await viewModel.login();

    if (user != null) {
      if (mounted) {
        context.go('/home');
      }
    } else {
      final err = ref.read(loginViewModelProvider).errorMessage;
      if (err != null) {
        ref.read(toastServiceProvider).showError(err);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginViewModelProvider);
    final viewModel = ref.read(loginViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('VTrace 로그인')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),
              const Text(
                '환영합니다!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'VTrace를 사용하기 위한 계정으로 로그인해주세요.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 48),

              VTraceTextField(
                label: '이메일 주소',
                controller: _emailController,
                hintText: 'example@gmail.com',
                errorText: loginState.emailError,
                onChanged: viewModel.onEmailChanged,
              ),
              const SizedBox(height: 24),

              VTraceTextField(
                label: '비밀번호',
                controller: _passwordController,
                hintText: '비밀번호를 입력하세요',
                obscureText: true,
                errorText: loginState.passwordError,
                onChanged: viewModel.onPasswordChanged,
              ),
              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: Checkbox(
                          value: loginState.rememberMe,
                          onChanged: viewModel.toggleRememberMe,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text('자동로그인', style: TextStyle(fontSize: 14)),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      context.push('/forgot-password');
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Text(
                      '비밀번호를 잊으셨나요?',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              VTraceButton(
                text: '로그인',
                isLoading: loginState.isLoading,
                onPressed: loginState.isValid ? _attemptLogin : null,
              ),
              const SizedBox(height: 24),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('계정이 없으신가요? '),
                  GestureDetector(
                    onTap: () {
                      context.push('/signup');
                    },
                    child: Text(
                      '여기를 눌러 가입하세요',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
