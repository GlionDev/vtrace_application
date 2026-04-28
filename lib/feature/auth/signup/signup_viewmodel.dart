import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/di/auth_usecase_module.dart';
import '../../../domain/models/auth_model.dart';
import 'signup_state.dart';

part 'signup_viewmodel.g.dart';

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

  /// 닉네임 입력값이 변경될 때 호출됩니다.
  ///
  /// [value] 변경된 닉네임 텍스트
  void onNicknameChanged(String value) {
    state = state.copyWith(nickname: value);
  }

  /// 이메일 인증 코드 발송을 요청합니다.
  ///
  /// 발송 후 5분(300초) 카운트다운 타이머를 시작합니다.
  Future<void> onSendVerificationCode() async {
    _timer?.cancel();
    state = state.copyWith(
      isCodeSent: true,
      isCodeVerified: false,
      timerSeconds: 300,
      isTimerRunning: true,
    );

    try {
      final useCase = await ref.read(
        sendEmailVerificationCodeUseCaseProvider.future,
      );
      await useCase(email: state.email);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    }

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.timerSeconds > 0) {
        state = state.copyWith(timerSeconds: state.timerSeconds - 1);
      } else {
        _timer?.cancel();
        state = state.copyWith(isTimerRunning: false, isCodeSent: false);
      }
    });
  }

  /// 이메일 입력값이 변경될 때 호출됩니다.
  ///
  /// [value] 변경된 이메일 텍스트
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

  /// 인증 코드 입력값이 변경될 때 호출됩니다.
  ///
  /// [value] 변경된 인증 코드 텍스트
  void onCodeChanged(String value) {
    state = state.copyWith(code: value, isCodeVerified: false);
  }

  /// 입력된 인증 코드의 유효성을 검증합니다.
  ///
  /// 반환값은 검증 성공 여부입니다.
  Future<bool> onVerifyCode() async {
    try {
      final useCase = await ref.read(verifyEmailCodeUseCaseProvider.future);
      final isValid = await useCase(email: state.email, code: state.code);

      if (isValid) {
        _timer?.cancel();
        state = state.copyWith(
          isCodeVerified: true,
          isTimerRunning: false,
          codeError: null,
          clearErrors: true,
        );
        return true;
      }

      state = state.copyWith(
        codeError: '인증 코드가 일치하지 않습니다.',
        isCodeVerified: false,
      );
      return false;
    } catch (e) {
      state = state.copyWith(
        codeError: '인증 코드가 일치하지 않습니다.',
        isCodeVerified: false,
      );
      return false;
    }
  }

  /// 비밀번호 입력값이 변경될 때 호출됩니다.
  ///
  /// [value] 변경된 비밀번호 텍스트
  void onPasswordChanged(String value) {
    String? err;
    if (value.isNotEmpty) {
      bool hasMinLength = value.length >= 10;
      bool hasUppercase = value.contains(RegExp(r'[A-Z]'));
      bool hasLowercase = value.contains(RegExp(r'[a-z]'));
      bool hasDigit = value.contains(RegExp(r'[0-9]'));
      bool hasSpecialCharacters = value.contains(RegExp(r'[!@#\$&*~]'));

      if (!hasMinLength ||
          !hasUppercase ||
          !hasLowercase ||
          !hasDigit ||
          !hasSpecialCharacters) {
        err = '대소문자, 숫자, 특수문자 포함 10자리 이상으로 입력해주세요';
      }
    }

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

  /// 비밀번호 확인 입력값이 변경될 때 호출됩니다.
  ///
  /// [value] 변경된 비밀번호 확인 텍스트
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
  ///
  /// 반환값은 가입 성공 시 획득한 [AuthUser] 입니다. 실패 시 null 을 반환합니다.
  Future<AuthUser?> register() async {
    if (!state.isValid) return null;

    state = state.copyWith(
      isLoading: true,
      errorMessage: null,
      clearErrors: true,
    );

    try {
      final useCase = await ref.read(registerUseCaseProvider.future);
      final user = await useCase(
        email: state.email,
        code: state.code,
        password: state.password,
      );

      state = state.copyWith(isLoading: false);
      return user;
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
      return null;
    }
  }
}
