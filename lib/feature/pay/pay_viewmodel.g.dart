// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pay_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 결제 로직과 결제 상태 스트림을 처리하는 뷰모델입니다.

@ProviderFor(PayViewModel)
final payViewModelProvider = PayViewModelProvider._();

/// 결제 로직과 결제 상태 스트림을 처리하는 뷰모델입니다.
final class PayViewModelProvider
    extends $NotifierProvider<PayViewModel, PayState> {
  /// 결제 로직과 결제 상태 스트림을 처리하는 뷰모델입니다.
  PayViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'payViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$payViewModelHash();

  @$internal
  @override
  PayViewModel create() => PayViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PayState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PayState>(value),
    );
  }
}

String _$payViewModelHash() => r'525a555d66cbf87cb9911f1bab513719ef1c9490';

/// 결제 로직과 결제 상태 스트림을 처리하는 뷰모델입니다.

abstract class _$PayViewModel extends $Notifier<PayState> {
  PayState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<PayState, PayState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PayState, PayState>,
              PayState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
