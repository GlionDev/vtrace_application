import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/di/auth_usecase_module.dart';
import 'forgot_password_state.dart';

part 'forgot_password_viewmodel.g.dart';

/// 비밀번호 찾기 화면의 상태와 로직을 제어하는 뷰모델입니다.
@riverpod
class ForgotPasswordViewModel extends _$ForgotPasswordViewModel {
  @override
  ForgotPasswordState build() => const ForgotPasswordState();

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

  /// 비밀번호 재설정 코드 발송을 요청합니다.
  ///
  /// 반환값은 발송 요청 성공 여부입니다.
  Future<bool> sendCode() async {
    if (!state.isValid) return false;

    state = state.copyWith(
      isLoading: true,
      errorMessage: null,
      clearErrors: true,
    );

    try {
      final useCase = await ref.read(
        sendPasswordResetCodeUseCaseProvider.future,
      );
      await useCase(email: state.email);

      state = state.copyWith(isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
      return false;
    }
  }
}
