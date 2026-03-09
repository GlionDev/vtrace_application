import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../core/design_system/widgets/vtrace_button.dart';
import '../../../../core/design_system/widgets/vtrace_textfield.dart';
import '../viewmodel/signup_viewmodel.dart';

/// 사용자가 계정 정보를 입력하여 회원가입을 요청하는 화면 위젯입니다.
class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _codeController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _showErrorToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 14.0,
    );
  }

  Future<void> _attemptSignUp() async {
    final viewModel = ref.read(signUpViewModelProvider.notifier);
    final user = await viewModel.register();

    if (user != null) {
      if (mounted) {
        Fluttertoast.showToast(msg: "회원가입 완료! 로그인 해주세요.");
        context.go('/login');
      }
    } else {
      final err = ref.read(signUpViewModelProvider).errorMessage;
      if (err != null) {
        _showErrorToast(err);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final signUpState = ref.watch(signUpViewModelProvider);
    final viewModel = ref.read(signUpViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('VTrace 회원가입')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: VTraceTextField(
                      controller: _emailController,
                      hintText: '이메일을 입력하세요',
                      errorText: signUpState.emailError,
                      isSuccess:
                          signUpState.email.isNotEmpty &&
                          signUpState.emailError == null,
                      onChanged: viewModel.onEmailChanged,
                    ),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    height: 56, // TextField 기본 높이에 맞춤
                    child: ElevatedButton(
                      onPressed:
                          (signUpState.email.isNotEmpty &&
                              signUpState.emailError == null &&
                              !signUpState.isLoading)
                          ? viewModel.onSendVerificationCode
                          : null,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: const Text(
                        '인증',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: VTraceTextField(
                      controller: _codeController,
                      hintText: '인증 코드를 입력하세요 (예: 1234)',
                      errorText: signUpState.codeError,
                      isSuccess:
                          signUpState.code.isNotEmpty &&
                          signUpState.codeError == null,
                      onChanged: viewModel.onCodeChanged,
                    ),
                  ),
                  if (signUpState.isCodeSent) ...[
                    const SizedBox(width: 8),
                    Container(
                      height: 56,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(
                        '${(signUpState.timerSeconds ~/ 60).toString().padLeft(2, '0')}:${(signUpState.timerSeconds % 60).toString().padLeft(2, '0')}',
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 16),

              VTraceTextField(
                controller: _passwordController,
                hintText: '비밀번호를 입력하세요',
                obscureText: true,
                errorText: signUpState.passwordError,
                isSuccess:
                    signUpState.password.isNotEmpty &&
                    signUpState.passwordError == null,
                onChanged: viewModel.onPasswordChanged,
              ),
              const SizedBox(height: 16),

              VTraceTextField(
                controller: _confirmPasswordController,
                hintText: '비밀번호를 다시 입력하세요',
                obscureText: true,
                errorText: signUpState.confirmPasswordError,
                isSuccess:
                    signUpState.confirmPassword.isNotEmpty &&
                    signUpState.confirmPasswordError == null,
                onChanged: viewModel.onConfirmPasswordChanged,
              ),
              const SizedBox(height: 32),

              VTraceButton(
                text: '회원가입',
                isLoading: signUpState.isLoading,
                onPressed: signUpState.isValid ? _attemptSignUp : null,
              ),
              const SizedBox(height: 16),

              TextButton(
                onPressed: () {
                  context.go('/login');
                },
                child: const Text('이미 계정이 있으신가요? 로그인하세요'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
