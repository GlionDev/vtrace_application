// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_module.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 외부 공유 인텐트 처리를 담당하는 [SharingIntentService] 를 제공합니다.
///
/// keepAlive 로 앱 수명 동안 유지되며, [Ref.onDispose] 로 정리됩니다.
/// 반환값은 공유 텍스트 스트림을 노출하는 서비스 객체입니다.

@ProviderFor(sharingIntentService)
final sharingIntentServiceProvider = SharingIntentServiceProvider._();

/// 외부 공유 인텐트 처리를 담당하는 [SharingIntentService] 를 제공합니다.
///
/// keepAlive 로 앱 수명 동안 유지되며, [Ref.onDispose] 로 정리됩니다.
/// 반환값은 공유 텍스트 스트림을 노출하는 서비스 객체입니다.

final class SharingIntentServiceProvider
    extends
        $FunctionalProvider<
          SharingIntentService,
          SharingIntentService,
          SharingIntentService
        >
    with $Provider<SharingIntentService> {
  /// 외부 공유 인텐트 처리를 담당하는 [SharingIntentService] 를 제공합니다.
  ///
  /// keepAlive 로 앱 수명 동안 유지되며, [Ref.onDispose] 로 정리됩니다.
  /// 반환값은 공유 텍스트 스트림을 노출하는 서비스 객체입니다.
  SharingIntentServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sharingIntentServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sharingIntentServiceHash();

  @$internal
  @override
  $ProviderElement<SharingIntentService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SharingIntentService create(Ref ref) {
    return sharingIntentService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SharingIntentService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SharingIntentService>(value),
    );
  }
}

String _$sharingIntentServiceHash() =>
    r'8a7a724dd74de033f49aa11f8da1b97e9c3d2332';

/// 외부 공유로 들어온 텍스트(URL 등)를 노출하는 스트림 프로바이더입니다.
///
/// 반환값은 새로운 공유 텍스트가 발생할 때마다 발행되는 [Stream] 입니다.

@ProviderFor(sharedText)
final sharedTextProvider = SharedTextProvider._();

/// 외부 공유로 들어온 텍스트(URL 등)를 노출하는 스트림 프로바이더입니다.
///
/// 반환값은 새로운 공유 텍스트가 발생할 때마다 발행되는 [Stream] 입니다.

final class SharedTextProvider
    extends $FunctionalProvider<AsyncValue<String>, String, Stream<String>>
    with $FutureModifier<String>, $StreamProvider<String> {
  /// 외부 공유로 들어온 텍스트(URL 등)를 노출하는 스트림 프로바이더입니다.
  ///
  /// 반환값은 새로운 공유 텍스트가 발생할 때마다 발행되는 [Stream] 입니다.
  SharedTextProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sharedTextProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sharedTextHash();

  @$internal
  @override
  $StreamProviderElement<String> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<String> create(Ref ref) {
    return sharedText(ref);
  }
}

String _$sharedTextHash() => r'3d5e677c5f76618e9b36325be8e7075d678b615c';
