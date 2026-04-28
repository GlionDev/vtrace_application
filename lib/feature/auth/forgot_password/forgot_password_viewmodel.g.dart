// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forgot_password_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 비밀번호 찾기 화면의 상태와 로직을 제어하는 뷰모델입니다.

@ProviderFor(ForgotPasswordViewModel)
final forgotPasswordViewModelProvider = ForgotPasswordViewModelProvider._();

/// 비밀번호 찾기 화면의 상태와 로직을 제어하는 뷰모델입니다.
final class ForgotPasswordViewModelProvider
    extends $NotifierProvider<ForgotPasswordViewModel, ForgotPasswordState> {
  /// 비밀번호 찾기 화면의 상태와 로직을 제어하는 뷰모델입니다.
  ForgotPasswordViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'forgotPasswordViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$forgotPasswordViewModelHash();

  @$internal
  @override
  ForgotPasswordViewModel create() => ForgotPasswordViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ForgotPasswordState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ForgotPasswordState>(value),
    );
  }
}

String _$forgotPasswordViewModelHash() =>
    r'5cc79fbfd10c62354fbd0a4c36d77a8fd8d2844b';

/// 비밀번호 찾기 화면의 상태와 로직을 제어하는 뷰모델입니다.

abstract class _$ForgotPasswordViewModel
    extends $Notifier<ForgotPasswordState> {
  ForgotPasswordState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ForgotPasswordState, ForgotPasswordState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ForgotPasswordState, ForgotPasswordState>,
              ForgotPasswordState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
