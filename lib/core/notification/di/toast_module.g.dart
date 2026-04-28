// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'toast_module.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 앱 전역에서 사용할 [ToastService] 인스턴스를 제공합니다.
///
/// 반환값은 토스트 메시지 출력을 담당하는 서비스 객체입니다.

@ProviderFor(toastService)
final toastServiceProvider = ToastServiceProvider._();

/// 앱 전역에서 사용할 [ToastService] 인스턴스를 제공합니다.
///
/// 반환값은 토스트 메시지 출력을 담당하는 서비스 객체입니다.

final class ToastServiceProvider
    extends $FunctionalProvider<ToastService, ToastService, ToastService>
    with $Provider<ToastService> {
  /// 앱 전역에서 사용할 [ToastService] 인스턴스를 제공합니다.
  ///
  /// 반환값은 토스트 메시지 출력을 담당하는 서비스 객체입니다.
  ToastServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'toastServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$toastServiceHash();

  @$internal
  @override
  $ProviderElement<ToastService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ToastService create(Ref ref) {
    return toastService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ToastService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ToastService>(value),
    );
  }
}

String _$toastServiceHash() => r'0e130424e5694f6a4f9e90d1792323a3b8831eb6';
