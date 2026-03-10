// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pay_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 결제 로직과 앱 결제 리스너를 처리하는 뷰모델입니다.

@ProviderFor(PayViewModel)
final payViewModelProvider = PayViewModelProvider._();

/// 결제 로직과 앱 결제 리스너를 처리하는 뷰모델입니다.
final class PayViewModelProvider
    extends $NotifierProvider<PayViewModel, PayState> {
  /// 결제 로직과 앱 결제 리스너를 처리하는 뷰모델입니다.
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

String _$payViewModelHash() => r'abca82ba48693dcf8c45cb9b5595bcc2c18b5224';

/// 결제 로직과 앱 결제 리스너를 처리하는 뷰모델입니다.

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
