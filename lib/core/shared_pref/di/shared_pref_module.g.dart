// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shared_pref_module.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 앱 전역에서 사용할 [SharedPreferences] 인스턴스를 제공합니다.
///
/// 각 데이터소스에서 비동기로 주입받아 키-값 저장소로 활용합니다.
/// 반환값은 초기화된 [SharedPreferences] 객체입니다.

@ProviderFor(sharedPreferences)
final sharedPreferencesProvider = SharedPreferencesProvider._();

/// 앱 전역에서 사용할 [SharedPreferences] 인스턴스를 제공합니다.
///
/// 각 데이터소스에서 비동기로 주입받아 키-값 저장소로 활용합니다.
/// 반환값은 초기화된 [SharedPreferences] 객체입니다.

final class SharedPreferencesProvider
    extends
        $FunctionalProvider<
          AsyncValue<SharedPreferences>,
          SharedPreferences,
          FutureOr<SharedPreferences>
        >
    with
        $FutureModifier<SharedPreferences>,
        $FutureProvider<SharedPreferences> {
  /// 앱 전역에서 사용할 [SharedPreferences] 인스턴스를 제공합니다.
  ///
  /// 각 데이터소스에서 비동기로 주입받아 키-값 저장소로 활용합니다.
  /// 반환값은 초기화된 [SharedPreferences] 객체입니다.
  SharedPreferencesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sharedPreferencesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sharedPreferencesHash();

  @$internal
  @override
  $FutureProviderElement<SharedPreferences> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<SharedPreferences> create(Ref ref) {
    return sharedPreferences(ref);
  }
}

String _$sharedPreferencesHash() => r'48e60558ea6530114ea20ea03e69b9fb339ab129';
