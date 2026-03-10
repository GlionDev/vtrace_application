import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../data/repositories/auth_repository_impl.dart';
import '../../../domain/models/auth_user.dart';

part 'login_viewmodel.g.dart';

/// 뷰모델에서 관리할 로그인 폼의 상태 클래스입니다.
class LoginState {
  /// 사용자가 입력한 이메일
  final String email;

  /// 사용자가 입력한 비밀번호
  final String password;

  /// 자동로그인 체크 여부
  final bool rememberMe;

  /// 진행 중 (로딩) 상태 여부
  final bool isLoading;

  /// 에러 발생 시 에러 메시지
  final String? errorMessage;

  /// 유효성 검증을 거친 후 발생한 이메일 필드의 에러
  final String? emailError;

  /// 유효성 검증을 거친 후 발생한 패스워드 필드의 에러
  final String? passwordError;

  /// [LoginState] 객체를 생성합니다.
  const LoginState({
    this.email = '',
    this.password = '',
    this.rememberMe = false,
    this.isLoading = false,
    this.errorMessage,
    this.emailError,
    this.passwordError,
  });

  /// 로그인 버튼 활성화 여부를 반환합니다.
  /// 모든 항목이 입력되었고 개별 에러가 없을 때 활성화됩니다.
  bool get isValid =>
      email.isNotEmpty &&
      password.isNotEmpty &&
      emailError == null &&
      passwordError == null;

  /// 기존 상태를 복사하여 일부 값만 변경한 새로운 인스턴스를 반환합니다.
  LoginState copyWith({
    String? email,
    String? password,
    bool? rememberMe,
    bool? isLoading,
    String? errorMessage,
    String? emailError,
    String? passwordError,
    bool clearErrors = false,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      rememberMe: rememberMe ?? this.rememberMe,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearErrors ? null : (errorMessage ?? this.errorMessage),
      emailError: clearErrors ? null : (emailError ?? this.emailError),
      passwordError: clearErrors ? null : (passwordError ?? this.passwordError),
    );
  }
}

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

  /// 자동로그인 상태 토글
  void toggleRememberMe(bool? value) {
    if (value != null) {
      state = state.copyWith(rememberMe: value);
    }
  }

  /// 사용자가 로그인 버튼을 클릭했을 때 호출되는 함수입니다.
  ///
  /// 반환값은 로그인 성공 시 획득한 [AuthUser] 입니다. 실패 시 null을 반환합니다.
  Future<AuthUser?> login() async {
    if (!state.isValid) return null;

    state = state.copyWith(
      isLoading: true,
      errorMessage: null,
      clearErrors: true,
    );

    try {
      final repository = ref.read(authRepositoryProvider);
      final user = await repository.login(state.email, state.password);

      state = state.copyWith(isLoading: false);
      return user;
    } catch (e) {
      // 일반적인 Exception (NetworkException 포함) 의 내부 메시지를 UI에 노출
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
      return null;
    }
  }
}
