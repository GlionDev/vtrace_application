// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 회원가입 화면의 상태를 제어하는 뷰모델입니다.

@ProviderFor(SignUpViewModel)
final signUpViewModelProvider = SignUpViewModelProvider._();

/// 회원가입 화면의 상태를 제어하는 뷰모델입니다.
final class SignUpViewModelProvider
    extends $NotifierProvider<SignUpViewModel, SignUpState> {
  /// 회원가입 화면의 상태를 제어하는 뷰모델입니다.
  SignUpViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'signUpViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$signUpViewModelHash();

  @$internal
  @override
  SignUpViewModel create() => SignUpViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SignUpState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SignUpState>(value),
    );
  }
}

String _$signUpViewModelHash() => r'01ab1bca837ed8b9f6944260dd46b43a422617d7';

/// 회원가입 화면의 상태를 제어하는 뷰모델입니다.

abstract class _$SignUpViewModel extends $Notifier<SignUpState> {
  SignUpState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<SignUpState, SignUpState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SignUpState, SignUpState>,
              SignUpState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
