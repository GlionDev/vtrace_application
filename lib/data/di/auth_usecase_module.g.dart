// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_usecase_module.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 로그인 UseCase 를 제공합니다.
///
/// 반환값은 [LoginUseCase] 인스턴스입니다.

@ProviderFor(loginUseCase)
final loginUseCaseProvider = LoginUseCaseProvider._();

/// 로그인 UseCase 를 제공합니다.
///
/// 반환값은 [LoginUseCase] 인스턴스입니다.

final class LoginUseCaseProvider
    extends
        $FunctionalProvider<
          AsyncValue<LoginUseCase>,
          LoginUseCase,
          FutureOr<LoginUseCase>
        >
    with $FutureModifier<LoginUseCase>, $FutureProvider<LoginUseCase> {
  /// 로그인 UseCase 를 제공합니다.
  ///
  /// 반환값은 [LoginUseCase] 인스턴스입니다.
  LoginUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'loginUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$loginUseCaseHash();

  @$internal
  @override
  $FutureProviderElement<LoginUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<LoginUseCase> create(Ref ref) {
    return loginUseCase(ref);
  }
}

String _$loginUseCaseHash() => r'2a201ee9d93eeb6243fc29643394d5fec3c56333';

/// 회원가입 UseCase 를 제공합니다.
///
/// 반환값은 [RegisterUseCase] 인스턴스입니다.

@ProviderFor(registerUseCase)
final registerUseCaseProvider = RegisterUseCaseProvider._();

/// 회원가입 UseCase 를 제공합니다.
///
/// 반환값은 [RegisterUseCase] 인스턴스입니다.

final class RegisterUseCaseProvider
    extends
        $FunctionalProvider<
          AsyncValue<RegisterUseCase>,
          RegisterUseCase,
          FutureOr<RegisterUseCase>
        >
    with $FutureModifier<RegisterUseCase>, $FutureProvider<RegisterUseCase> {
  /// 회원가입 UseCase 를 제공합니다.
  ///
  /// 반환값은 [RegisterUseCase] 인스턴스입니다.
  RegisterUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'registerUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$registerUseCaseHash();

  @$internal
  @override
  $FutureProviderElement<RegisterUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<RegisterUseCase> create(Ref ref) {
    return registerUseCase(ref);
  }
}

String _$registerUseCaseHash() => r'e4acd455ceb35391ca2a5853ff357960af1c97e8';

/// 이메일 인증 코드 발송 UseCase 를 제공합니다.
///
/// 반환값은 [SendEmailVerificationCodeUseCase] 인스턴스입니다.

@ProviderFor(sendEmailVerificationCodeUseCase)
final sendEmailVerificationCodeUseCaseProvider =
    SendEmailVerificationCodeUseCaseProvider._();

/// 이메일 인증 코드 발송 UseCase 를 제공합니다.
///
/// 반환값은 [SendEmailVerificationCodeUseCase] 인스턴스입니다.

final class SendEmailVerificationCodeUseCaseProvider
    extends
        $FunctionalProvider<
          AsyncValue<SendEmailVerificationCodeUseCase>,
          SendEmailVerificationCodeUseCase,
          FutureOr<SendEmailVerificationCodeUseCase>
        >
    with
        $FutureModifier<SendEmailVerificationCodeUseCase>,
        $FutureProvider<SendEmailVerificationCodeUseCase> {
  /// 이메일 인증 코드 발송 UseCase 를 제공합니다.
  ///
  /// 반환값은 [SendEmailVerificationCodeUseCase] 인스턴스입니다.
  SendEmailVerificationCodeUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sendEmailVerificationCodeUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sendEmailVerificationCodeUseCaseHash();

  @$internal
  @override
  $FutureProviderElement<SendEmailVerificationCodeUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<SendEmailVerificationCodeUseCase> create(Ref ref) {
    return sendEmailVerificationCodeUseCase(ref);
  }
}

String _$sendEmailVerificationCodeUseCaseHash() =>
    r'5e75bbc89061d3753e51c97c268467dcf9601963';

/// 이메일 인증 코드 검증 UseCase 를 제공합니다.
///
/// 반환값은 [VerifyEmailCodeUseCase] 인스턴스입니다.

@ProviderFor(verifyEmailCodeUseCase)
final verifyEmailCodeUseCaseProvider = VerifyEmailCodeUseCaseProvider._();

/// 이메일 인증 코드 검증 UseCase 를 제공합니다.
///
/// 반환값은 [VerifyEmailCodeUseCase] 인스턴스입니다.

final class VerifyEmailCodeUseCaseProvider
    extends
        $FunctionalProvider<
          AsyncValue<VerifyEmailCodeUseCase>,
          VerifyEmailCodeUseCase,
          FutureOr<VerifyEmailCodeUseCase>
        >
    with
        $FutureModifier<VerifyEmailCodeUseCase>,
        $FutureProvider<VerifyEmailCodeUseCase> {
  /// 이메일 인증 코드 검증 UseCase 를 제공합니다.
  ///
  /// 반환값은 [VerifyEmailCodeUseCase] 인스턴스입니다.
  VerifyEmailCodeUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'verifyEmailCodeUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$verifyEmailCodeUseCaseHash();

  @$internal
  @override
  $FutureProviderElement<VerifyEmailCodeUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<VerifyEmailCodeUseCase> create(Ref ref) {
    return verifyEmailCodeUseCase(ref);
  }
}

String _$verifyEmailCodeUseCaseHash() =>
    r'a1d66da838c567d03c4708e109592687e3f75a56';

/// 비밀번호 재설정 코드 발송 UseCase 를 제공합니다.
///
/// 반환값은 [SendPasswordResetCodeUseCase] 인스턴스입니다.

@ProviderFor(sendPasswordResetCodeUseCase)
final sendPasswordResetCodeUseCaseProvider =
    SendPasswordResetCodeUseCaseProvider._();

/// 비밀번호 재설정 코드 발송 UseCase 를 제공합니다.
///
/// 반환값은 [SendPasswordResetCodeUseCase] 인스턴스입니다.

final class SendPasswordResetCodeUseCaseProvider
    extends
        $FunctionalProvider<
          AsyncValue<SendPasswordResetCodeUseCase>,
          SendPasswordResetCodeUseCase,
          FutureOr<SendPasswordResetCodeUseCase>
        >
    with
        $FutureModifier<SendPasswordResetCodeUseCase>,
        $FutureProvider<SendPasswordResetCodeUseCase> {
  /// 비밀번호 재설정 코드 발송 UseCase 를 제공합니다.
  ///
  /// 반환값은 [SendPasswordResetCodeUseCase] 인스턴스입니다.
  SendPasswordResetCodeUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sendPasswordResetCodeUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sendPasswordResetCodeUseCaseHash();

  @$internal
  @override
  $FutureProviderElement<SendPasswordResetCodeUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<SendPasswordResetCodeUseCase> create(Ref ref) {
    return sendPasswordResetCodeUseCase(ref);
  }
}

String _$sendPasswordResetCodeUseCaseHash() =>
    r'757eb20fea2e2c866dbc67e1ef796febbb79b6da';
