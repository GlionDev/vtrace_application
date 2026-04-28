/// 뷰모델에서 관리할 회원가입 폼의 상태 클래스입니다.
class SignUpState {
  /// 입력된 닉네임
  final String nickname;

  /// 입력된 이메일
  final String email;

  /// 입력된 인증 코드
  final String code;

  /// 입력된 비밀번호
  final String password;

  /// 입력된 비밀번호 확인 값
  final String confirmPassword;

  /// 인증 코드 발송 후 남은 타이머 초
  final int timerSeconds;

  /// 타이머가 동작 중인지 여부
  final bool isTimerRunning;

  /// 인증 코드 발송 여부
  final bool isCodeSent;

  /// 인증 코드 검증 성공 여부
  final bool isCodeVerified;

  /// 회원가입 진행(로딩) 여부
  final bool isLoading;

  /// 일반 에러 메시지
  final String? errorMessage;

  /// 이메일 필드 에러 메시지
  final String? emailError;

  /// 인증 코드 필드 에러 메시지
  final String? codeError;

  /// 비밀번호 필드 에러 메시지
  final String? passwordError;

  /// 비밀번호 확인 필드 에러 메시지
  final String? confirmPasswordError;

  /// [SignUpState] 객체를 생성합니다.
  const SignUpState({
    this.nickname = '',
    this.email = '',
    this.code = '',
    this.password = '',
    this.confirmPassword = '',
    this.timerSeconds = 300,
    this.isTimerRunning = false,
    this.isCodeSent = false,
    this.isCodeVerified = false,
    this.isLoading = false,
    this.errorMessage,
    this.emailError,
    this.codeError,
    this.passwordError,
    this.confirmPasswordError,
  });

  /// 모든 항목이 입력되었고 개별 에러가 없을 때 가입 버튼이 활성화됩니다.
  bool get isValid =>
      nickname.isNotEmpty &&
      email.isNotEmpty &&
      code.isNotEmpty &&
      isCodeVerified &&
      password.isNotEmpty &&
      confirmPassword.isNotEmpty &&
      emailError == null &&
      codeError == null &&
      passwordError == null &&
      confirmPasswordError == null;

  /// 기존 상태를 복사하여 일부 값만 변경한 새로운 인스턴스를 반환합니다.
  ///
  /// 각 인자의 의미는 동일 이름의 필드와 같으며,
  /// [clearErrors] 가 true 이면 모든 에러 필드를 초기화합니다.
  /// 반환값은 새로 생성된 [SignUpState] 객체입니다.
  SignUpState copyWith({
    String? nickname,
    String? email,
    String? code,
    String? password,
    String? confirmPassword,
    int? timerSeconds,
    bool? isTimerRunning,
    bool? isCodeSent,
    bool? isCodeVerified,
    bool? isLoading,
    String? errorMessage,
    String? emailError,
    String? codeError,
    String? passwordError,
    String? confirmPasswordError,
    bool clearErrors = false,
  }) {
    return SignUpState(
      nickname: nickname ?? this.nickname,
      email: email ?? this.email,
      code: code ?? this.code,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      timerSeconds: timerSeconds ?? this.timerSeconds,
      isTimerRunning: isTimerRunning ?? this.isTimerRunning,
      isCodeSent: isCodeSent ?? this.isCodeSent,
      isCodeVerified: isCodeVerified ?? this.isCodeVerified,
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
