// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_router.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 앱 전반의 라우팅을 담당하는 [GoRouter] 객체를 제공합니다.
///
/// Riverpod을 통해 전역 관리되며, 앱의 네비게이션 트리와 초기 경로를 설정합니다.

@ProviderFor(appRouter)
final appRouterProvider = AppRouterProvider._();

/// 앱 전반의 라우팅을 담당하는 [GoRouter] 객체를 제공합니다.
///
/// Riverpod을 통해 전역 관리되며, 앱의 네비게이션 트리와 초기 경로를 설정합니다.

final class AppRouterProvider
    extends $FunctionalProvider<GoRouter, GoRouter, GoRouter>
    with $Provider<GoRouter> {
  /// 앱 전반의 라우팅을 담당하는 [GoRouter] 객체를 제공합니다.
  ///
  /// Riverpod을 통해 전역 관리되며, 앱의 네비게이션 트리와 초기 경로를 설정합니다.
  AppRouterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appRouterProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appRouterHash();

  @$internal
  @override
  $ProviderElement<GoRouter> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GoRouter create(Ref ref) {
    return appRouter(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GoRouter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GoRouter>(value),
    );
  }
}

String _$appRouterHash() => r'763ba99f8ba1d5205d2e5146f3213a83b576a205';
