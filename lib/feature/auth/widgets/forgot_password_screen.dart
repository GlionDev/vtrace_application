import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../core/design_system/widgets/vtrace_button.dart';
import '../../../core/design_system/widgets/vtrace_textfield.dart';
import '../viewmodel/forgot_password_viewmodel.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
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

  Future<void> _attemptSendCode() async {
    final viewModel = ref.read(forgotPasswordViewModelProvider.notifier);
    final isSuccess = await viewModel.sendCode();

    if (isSuccess) {
      if (mounted) {
        Fluttertoast.showToast(msg: "해당 이메일로 코드가 전송되었습니다.");
      }
    } else {
      final err = ref.read(forgotPasswordViewModelProvider).errorMessage;
      if (err != null) {
        _showErrorToast(err);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final forgotPasswordState = ref.watch(forgotPasswordViewModelProvider);
    final viewModel = ref.read(forgotPasswordViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('비밀번호 찾기')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),
              // 헤더 타이틀
              const Text(
                '비밀번호를 잊으셨나요?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              // 서브타이틀
              const Text(
                '이메일 주소를 입력하시면 인증 코드를 보내드립니다.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 48),

              // 이메일 입력 영역
              VTraceTextField(
                label: '이메일 주소',
                controller: _emailController,
                hintText: 'example@gmail.com',
                errorText: forgotPasswordState.emailError,
                onChanged: viewModel.onEmailChanged,
              ),
              const SizedBox(height: 32),

              // 코드 발송 버튼
              VTraceButton(
                text: '코드 전송하기',
                isLoading: forgotPasswordState.isLoading,
                onPressed: forgotPasswordState.isValid
                    ? _attemptSendCode
                    : null,
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
