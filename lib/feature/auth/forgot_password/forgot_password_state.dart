/// 뷰모델에서 관리할 비밀번호 찾기 화면의 상태 클래스입니다.
class ForgotPasswordState {
  /// 입력된 이메일
  final String email;

  /// 코드 발송 진행(로딩) 여부
  final bool isLoading;

  /// 일반 에러 메시지
  final String? errorMessage;

  /// 이메일 필드 에러 메시지
  final String? emailError;

  /// [ForgotPasswordState] 객체를 생성합니다.
  const ForgotPasswordState({
    this.email = '',
    this.isLoading = false,
    this.errorMessage,
    this.emailError,
  });

  /// 코드 전송 버튼 활성화 여부를 반환합니다.
  bool get isValid => email.isNotEmpty && emailError == null;

  /// 기존 상태를 복사하여 일부 값만 변경한 새로운 인스턴스를 반환합니다.
  ///
  /// [clearErrors] 가 true 이면 모든 에러 필드를 초기화합니다.
  /// 반환값은 새로 생성된 [ForgotPasswordState] 객체입니다.
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
