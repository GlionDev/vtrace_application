// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'env_module.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 현재 빌드 환경에 해당하는 [AppEnv] 인스턴스를 제공합니다.
///
/// `--dart-define=FLAVOR=...` 로 주입된 값에 따라 dev/staging/prod 중 하나가 반환됩니다.
/// 반환값은 환경별 설정값이 담긴 [AppEnv] 객체입니다.

@ProviderFor(appEnv)
final appEnvProvider = AppEnvProvider._();

/// 현재 빌드 환경에 해당하는 [AppEnv] 인스턴스를 제공합니다.
///
/// `--dart-define=FLAVOR=...` 로 주입된 값에 따라 dev/staging/prod 중 하나가 반환됩니다.
/// 반환값은 환경별 설정값이 담긴 [AppEnv] 객체입니다.

final class AppEnvProvider extends $FunctionalProvider<AppEnv, AppEnv, AppEnv>
    with $Provider<AppEnv> {
  /// 현재 빌드 환경에 해당하는 [AppEnv] 인스턴스를 제공합니다.
  ///
  /// `--dart-define=FLAVOR=...` 로 주입된 값에 따라 dev/staging/prod 중 하나가 반환됩니다.
  /// 반환값은 환경별 설정값이 담긴 [AppEnv] 객체입니다.
  AppEnvProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appEnvProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appEnvHash();

  @$internal
  @override
  $ProviderElement<AppEnv> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppEnv create(Ref ref) {
    return appEnv(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppEnv value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppEnv>(value),
    );
  }
}

String _$appEnvHash() => r'3c4208dd3e5f7e7a3959c16d4f5ce68d5b5ac6d6';
