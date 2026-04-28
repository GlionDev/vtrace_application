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
  ///
  /// 모든 항목이 입력되었고 개별 에러가 없을 때 활성화됩니다.
  bool get isValid =>
      email.isNotEmpty &&
      password.isNotEmpty &&
      emailError == null &&
      passwordError == null;

  /// 기존 상태를 복사하여 일부 값만 변경한 새로운 인스턴스를 반환합니다.
  ///
  /// [email] 변경할 이메일
  /// [password] 변경할 비밀번호
  /// [rememberMe] 변경할 자동로그인 플래그
  /// [isLoading] 변경할 로딩 플래그
  /// [errorMessage] 변경할 일반 에러 메시지
  /// [emailError] 변경할 이메일 필드 에러 메시지
  /// [passwordError] 변경할 비밀번호 필드 에러 메시지
  /// [clearErrors] true 인 경우 모든 에러 필드를 초기화합니다.
  /// 반환값은 새로 생성된 [LoginState] 객체입니다.
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
