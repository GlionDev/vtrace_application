// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 로그인 화면의 상태 및 비즈니스 로직을 제어하는 뷰모델입니다.

@ProviderFor(LoginViewModel)
final loginViewModelProvider = LoginViewModelProvider._();

/// 로그인 화면의 상태 및 비즈니스 로직을 제어하는 뷰모델입니다.
final class LoginViewModelProvider
    extends $NotifierProvider<LoginViewModel, LoginState> {
  /// 로그인 화면의 상태 및 비즈니스 로직을 제어하는 뷰모델입니다.
  LoginViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'loginViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$loginViewModelHash();

  @$internal
  @override
  LoginViewModel create() => LoginViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LoginState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LoginState>(value),
    );
  }
}

String _$loginViewModelHash() => r'910529d5cc95952a8b474c7b32574a38db47eb41';

/// 로그인 화면의 상태 및 비즈니스 로직을 제어하는 뷰모델입니다.

abstract class _$LoginViewModel extends $Notifier<LoginState> {
  LoginState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<LoginState, LoginState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<LoginState, LoginState>,
              LoginState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
