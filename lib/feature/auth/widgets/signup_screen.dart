import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../core/design_system/widgets/vtrace_button.dart';
import '../../../core/design_system/widgets/vtrace_textfield.dart';
import '../viewmodel/signup_viewmodel.dart';

/// 사용자가 계정 정보를 입력하여 회원가입을 요청하는 화면 위젯입니다.
class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _nicknameController.dispose();
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
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),
              // 헤더 타이틀
              const Text(
                '계정 생성',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              // 서브타이틀
              const Text(
                'VTrace를 사용하기 위한 계정을 생성합니다',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 48),

              // 닉네임 입력란
              VTraceTextField(
                label: '닉네임',
                controller: _nicknameController,
                hintText: '닉네임을 입력하세요',
                isSuccess: signUpState.nickname.isNotEmpty,
                onChanged: viewModel.onNicknameChanged,
              ),
              const SizedBox(height: 16),

              // 이메일과 인증버튼
              const Text(
                '이메일 주소',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
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
                  if (signUpState.isCodeSent) ...[
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
                  ] else ...[
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
                          '코드전송',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 16),

              // 인증 코드 입력란 (타이머 포함)
              const Text(
                '인증 코드',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: VTraceTextField(
                      controller: _codeController,
                      hintText: '인증 코드를 입력하세요',
                      errorText: signUpState.codeError,
                      isSuccess: signUpState.isCodeVerified,
                      onChanged: viewModel.onCodeChanged,
                    ),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    height: 56, // TextField 기본 높이에 맞춤
                    child: ElevatedButton(
                      onPressed: (signUpState.code.isNotEmpty)
                          ? viewModel.onVerifyCode
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

              // 비밀번호 입력란
              VTraceTextField(
                label: '비밀번호',
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

              // 비밀번호 확인 입력란
              VTraceTextField(
                label: '비밀번호 확인',
                controller: _confirmPasswordController,
                hintText: '비밀번호를 다시 입력하세요',
                obscureText: true,
                errorText: signUpState.confirmPasswordError,
                isSuccess:
                    signUpState.confirmPassword.isNotEmpty &&
                    signUpState.confirmPasswordError == null,
                onChanged: viewModel.onConfirmPasswordChanged,
              ),
              const SizedBox(height: 48),

              // 회원가입 버튼
              VTraceButton(
                text: '회원가입',
                isLoading: signUpState.isLoading,
                onPressed: signUpState.isValid ? _attemptSignUp : null,
              ),
              const SizedBox(height: 24),

              // 하단 로그인 이동 유도
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('이미 계정이 있으신가요? '),
                  GestureDetector(
                    onTap: () {
                      context.go('/login');
                    },
                    child: Text(
                      '로그인하세요',
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
