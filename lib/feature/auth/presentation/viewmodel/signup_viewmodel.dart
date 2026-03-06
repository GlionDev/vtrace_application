import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../data/repositories/auth_repository_impl.dart';
import '../../../../domain/models/auth_user.dart';

part 'signup_viewmodel.g.dart';

/// 뷰모델에서 관리할 회원가입 폼의 상태 클래스입니다.
class SignUpState {
  final String email;
  final String code;
  final String password;
  final String confirmPassword;

  final int timerSeconds;
  final bool isTimerRunning;
  final bool isCodeSent;

  final bool isLoading;
  final String? errorMessage;

  final String? emailError;
  final String? codeError;
  final String? passwordError;
  final String? confirmPasswordError;

  const SignUpState({
    this.email = '',
    this.code = '',
    this.password = '',
    this.confirmPassword = '',
    this.timerSeconds = 300,
    this.isTimerRunning = false,
    this.isCodeSent = false,
    this.isLoading = false,
    this.errorMessage,
    this.emailError,
    this.codeError,
    this.passwordError,
    this.confirmPasswordError,
  });

  /// 모든 항목이 입력되었고 개별 에러가 없을 때 가입 버튼이 활성화됩니다.
  bool get isValid =>
      email.isNotEmpty &&
      code.isNotEmpty &&
      password.isNotEmpty &&
      confirmPassword.isNotEmpty &&
      emailError == null &&
      codeError == null &&
      passwordError == null &&
      confirmPasswordError == null;

  SignUpState copyWith({
    String? email,
    String? code,
    String? password,
    String? confirmPassword,
    int? timerSeconds,
    bool? isTimerRunning,
    bool? isCodeSent,
    bool? isLoading,
    String? errorMessage,
    String? emailError,
    String? codeError,
    String? passwordError,
    String? confirmPasswordError,
    bool clearErrors = false,
  }) {
    return SignUpState(
      email: email ?? this.email,
      code: code ?? this.code,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      timerSeconds: timerSeconds ?? this.timerSeconds,
      isTimerRunning: isTimerRunning ?? this.isTimerRunning,
      isCodeSent: isCodeSent ?? this.isCodeSent,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearErrors ? null : (errorMessage ?? this.errorMessage),
      emailError: clearErrors ? null : (emailError ?? this.emailError),
      codeError: clearErrors ? null : (codeError ?? this.codeError),
      passwordError: clearErrors ? null : (passwordError ?? this.passwordError),
      confirmPasswordError: clearErrors
          ? null
          : (confirmPasswordError ?? this.confirmPasswordError),
    );
  }
}

/// 회원가입 화면의 상태를 제어하는 뷰모델입니다.
@riverpod
class SignUpViewModel extends _$SignUpViewModel {
  Timer? _timer;

  @override
  SignUpState build() {
    ref.onDispose(() {
      _timer?.cancel();
    });
    return const SignUpState();
  }

  void onSendVerificationCode() {
    _timer?.cancel();
    state = state.copyWith(
      isCodeSent: true,
      timerSeconds: 300,
      isTimerRunning: true,
    );

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.timerSeconds > 0) {
        state = state.copyWith(timerSeconds: state.timerSeconds - 1);
      } else {
        timer.cancel();
        state = state.copyWith(isTimerRunning: false);
      }
    });
  }

  void onEmailChanged(String value) {
    String? err;
    if (value.isNotEmpty && !value.contains('@')) {
      err = '이메일 형식으로 입력해주세요.';
    }
    state = state.copyWith(
      email: value,
      emailError: err,
      clearErrors: err == null,
    );
  }

  void onCodeChanged(String value) {
    // 요구사항 상 인증번호 길이나 형식에 대한 에러 메시지는 구체적이지 않지만 임의 검증 부여
    String? err;
    if (value.isNotEmpty && value.length < 4) {
      err = '인증 코드를 올바르게 입력해주세요.';
    }
    state = state.copyWith(
      code: value,
      codeError: err,
      clearErrors: err == null,
    );
  }

  void onPasswordChanged(String value) {
    String? err;
    if (value.isNotEmpty) {
      bool hasMinLength = value.length >= 10;
      bool hasUppercase = value.contains(RegExp(r'[A-Z]'));
      bool hasLowercase = value.contains(RegExp(r'[a-z]'));
      bool hasSpecialCharacters = value.contains(RegExp(r'[!@#\$&*~]'));

      if (!hasMinLength ||
          !hasUppercase ||
          !hasLowercase ||
          !hasSpecialCharacters) {
        err = '대소문자, 특수문자 포함 10자리로 설정해주세요';
      }
    }

    // 비밀번호가 변경되었으므로 비밀번호 확인란도 다시 검증
    String? confirmErr;
    if (state.confirmPassword.isNotEmpty && state.confirmPassword != value) {
      confirmErr = '비밀번호가 일치하지 않습니다.';
    }

    state = state.copyWith(
      password: value,
      passwordError: err,
      confirmPasswordError: confirmErr,
      clearErrors: err == null && confirmErr == null,
    );
  }

  void onConfirmPasswordChanged(String value) {
    String? err;
    if (value.isNotEmpty && value != state.password) {
      err = '비밀번호가 일치하지 않습니다.';
    }
    state = state.copyWith(
      confirmPassword: value,
      confirmPasswordError: err,
      clearErrors: err == null,
    );
  }

  /// 사용자가 회원가입 버튼을 클릭했을 때 호출되는 함수입니다.
  Future<AuthUser?> register() async {
    if (!state.isValid) return null;

    state = state.copyWith(
      isLoading: true,
      errorMessage: null,
      clearErrors: true,
    );

    try {
      final repository = ref.read(authRepositoryProvider);
      final user = await repository.register(
        state.email,
        state.code,
        state.password,
      );

      state = state.copyWith(isLoading: false);
      return user;
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
      return null;
    }
  }
}
