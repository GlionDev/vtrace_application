// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 홈 화면의 사용자 입력 및 로직을 처리하는 뷰모델입니다.

@ProviderFor(HomeViewModel)
final homeViewModelProvider = HomeViewModelProvider._();

/// 홈 화면의 사용자 입력 및 로직을 처리하는 뷰모델입니다.
final class HomeViewModelProvider
    extends $NotifierProvider<HomeViewModel, HomeState> {
  /// 홈 화면의 사용자 입력 및 로직을 처리하는 뷰모델입니다.
  HomeViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeViewModelHash();

  @$internal
  @override
  HomeViewModel create() => HomeViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HomeState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HomeState>(value),
    );
  }
}

String _$homeViewModelHash() => r'68c9e446ccabc68e07dca5020b8c895d8c656a9b';

/// 홈 화면의 사용자 입력 및 로직을 처리하는 뷰모델입니다.

abstract class _$HomeViewModel extends $Notifier<HomeState> {
  HomeState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<HomeState, HomeState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<HomeState, HomeState>,
              HomeState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
