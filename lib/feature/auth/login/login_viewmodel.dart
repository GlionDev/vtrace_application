import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/di/auth_usecase_module.dart';
import '../../../domain/models/auth_model.dart';
import 'login_state.dart';

part 'login_viewmodel.g.dart';

/// 로그인 화면의 상태 및 비즈니스 로직을 제어하는 뷰모델입니다.
@riverpod
class LoginViewModel extends _$LoginViewModel {
  @override
  LoginState build() => const LoginState();

  /// 이메일 텍스트가 변경될 때마다 호출되어 상태를 갱신합니다.
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

  /// 패스워드 텍스트가 변경될 때마다 호출되어 상태를 갱신합니다.
  ///
  /// [value] 변경된 패스워드 텍스트
  void onPasswordChanged(String value) {
    state = state.copyWith(
      password: value,
      passwordError: null,
      clearErrors: true,
    );
  }

  /// 자동로그인 체크 상태를 토글합니다.
  ///
  /// [value] 새로 적용할 자동로그인 플래그
  void toggleRememberMe(bool? value) {
    if (value != null) {
      state = state.copyWith(rememberMe: value);
    }
  }

  /// 사용자가 로그인 버튼을 클릭했을 때 호출되는 함수입니다.
  ///
  /// 반환값은 로그인 성공 시 획득한 [AuthUser] 입니다. 실패 시 null 을 반환합니다.
  Future<AuthUser?> login() async {
    if (!state.isValid) return null;

    state = state.copyWith(
      isLoading: true,
      errorMessage: null,
      clearErrors: true,
    );

    try {
      final useCase = await ref.read(loginUseCaseProvider.future);
      final user = await useCase(email: state.email, password: state.password);

      state = state.copyWith(isLoading: false);
      return user;
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
      return null;
    }
  }
}
