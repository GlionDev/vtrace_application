// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'secure_storage_module.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 토큰 등 민감한 데이터를 저장하기 위한 [FlutterSecureStorage] 인스턴스를 제공합니다.
///
/// 반환값은 보안 키체인/Keystore 에 접근할 수 있는 스토리지 객체입니다.

@ProviderFor(secureStorage)
final secureStorageProvider = SecureStorageProvider._();

/// 토큰 등 민감한 데이터를 저장하기 위한 [FlutterSecureStorage] 인스턴스를 제공합니다.
///
/// 반환값은 보안 키체인/Keystore 에 접근할 수 있는 스토리지 객체입니다.

final class SecureStorageProvider
    extends
        $FunctionalProvider<
          FlutterSecureStorage,
          FlutterSecureStorage,
          FlutterSecureStorage
        >
    with $Provider<FlutterSecureStorage> {
  /// 토큰 등 민감한 데이터를 저장하기 위한 [FlutterSecureStorage] 인스턴스를 제공합니다.
  ///
  /// 반환값은 보안 키체인/Keystore 에 접근할 수 있는 스토리지 객체입니다.
  SecureStorageProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'secureStorageProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$secureStorageHash();

  @$internal
  @override
  $ProviderElement<FlutterSecureStorage> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FlutterSecureStorage create(Ref ref) {
    return secureStorage(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FlutterSecureStorage value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FlutterSecureStorage>(value),
    );
  }
}

String _$secureStorageHash() => r'a4f75721472cf77465bf47f759c90de5ca30856e';
