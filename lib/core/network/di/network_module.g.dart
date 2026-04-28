// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'network_module.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 앱 내에서 전역으로 사용할 [Dio] 인스턴스를 제공하는 프로바이더입니다.
///
/// Riverpod DI를 통해 각 DataSource 에 HTTP 클라이언트를 주입할 때 사용됩니다.
/// 반환값은 환경 설정에 맞춰 구성된 [Dio] 객체입니다.

@ProviderFor(dio)
final dioProvider = DioProvider._();

/// 앱 내에서 전역으로 사용할 [Dio] 인스턴스를 제공하는 프로바이더입니다.
///
/// Riverpod DI를 통해 각 DataSource 에 HTTP 클라이언트를 주입할 때 사용됩니다.
/// 반환값은 환경 설정에 맞춰 구성된 [Dio] 객체입니다.

final class DioProvider extends $FunctionalProvider<Dio, Dio, Dio>
    with $Provider<Dio> {
  /// 앱 내에서 전역으로 사용할 [Dio] 인스턴스를 제공하는 프로바이더입니다.
  ///
  /// Riverpod DI를 통해 각 DataSource 에 HTTP 클라이언트를 주입할 때 사용됩니다.
  /// 반환값은 환경 설정에 맞춰 구성된 [Dio] 객체입니다.
  DioProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dioProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dioHash();

  @$internal
  @override
  $ProviderElement<Dio> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Dio create(Ref ref) {
    return dio(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Dio value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Dio>(value),
    );
  }
}

String _$dioHash() => r'9d1e019770f981ee74cc28f5e5694a02dd102d14';
