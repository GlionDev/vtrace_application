import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'forgot_password_viewmodel.g.dart';

class ForgotPasswordState {
  final String email;
  final bool isLoading;
  final String? errorMessage;
  final String? emailError;

  const ForgotPasswordState({
    this.email = '',
    this.isLoading = false,
    this.errorMessage,
    this.emailError,
  });

  bool get isValid => email.isNotEmpty && emailError == null;

  ForgotPasswordState copyWith({
    String? email,
    bool? isLoading,
    String? errorMessage,
    String? emailError,
    bool clearErrors = false,
  }) {
    return ForgotPasswordState(
      email: email ?? this.email,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearErrors ? null : (errorMessage ?? this.errorMessage),
      emailError: clearErrors ? null : (emailError ?? this.emailError),
    );
  }
}

@riverpod
class ForgotPasswordViewModel extends _$ForgotPasswordViewModel {
  @override
  ForgotPasswordState build() => const ForgotPasswordState();

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

  Future<bool> sendCode() async {
    if (!state.isValid) return false;

    state = state.copyWith(
      isLoading: true,
      errorMessage: null,
      clearErrors: true,
    );

    try {
      // Mock API delay
      await Future.delayed(const Duration(seconds: 2));

      state = state.copyWith(isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
      return false;
    }
  }
}
