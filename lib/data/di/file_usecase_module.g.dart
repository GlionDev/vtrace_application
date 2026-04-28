// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_usecase_module.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 오디오 파일 선택 UseCase 를 제공합니다.
///
/// 반환값은 [PickAudioFileUseCase] 인스턴스입니다.

@ProviderFor(pickAudioFileUseCase)
final pickAudioFileUseCaseProvider = PickAudioFileUseCaseProvider._();

/// 오디오 파일 선택 UseCase 를 제공합니다.
///
/// 반환값은 [PickAudioFileUseCase] 인스턴스입니다.

final class PickAudioFileUseCaseProvider
    extends
        $FunctionalProvider<
          PickAudioFileUseCase,
          PickAudioFileUseCase,
          PickAudioFileUseCase
        >
    with $Provider<PickAudioFileUseCase> {
  /// 오디오 파일 선택 UseCase 를 제공합니다.
  ///
  /// 반환값은 [PickAudioFileUseCase] 인스턴스입니다.
  PickAudioFileUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pickAudioFileUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pickAudioFileUseCaseHash();

  @$internal
  @override
  $ProviderElement<PickAudioFileUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PickAudioFileUseCase create(Ref ref) {
    return pickAudioFileUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PickAudioFileUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PickAudioFileUseCase>(value),
    );
  }
}

String _$pickAudioFileUseCaseHash() =>
    r'1cfd8f07f8529dbd2c4f46407db4533850e3c45e';

/// 시스템 앱 설정 화면 호출 UseCase 를 제공합니다.
///
/// 반환값은 [OpenAppSettingsUseCase] 인스턴스입니다.

@ProviderFor(openAppSettingsUseCase)
final openAppSettingsUseCaseProvider = OpenAppSettingsUseCaseProvider._();

/// 시스템 앱 설정 화면 호출 UseCase 를 제공합니다.
///
/// 반환값은 [OpenAppSettingsUseCase] 인스턴스입니다.

final class OpenAppSettingsUseCaseProvider
    extends
        $FunctionalProvider<
          OpenAppSettingsUseCase,
          OpenAppSettingsUseCase,
          OpenAppSettingsUseCase
        >
    with $Provider<OpenAppSettingsUseCase> {
  /// 시스템 앱 설정 화면 호출 UseCase 를 제공합니다.
  ///
  /// 반환값은 [OpenAppSettingsUseCase] 인스턴스입니다.
  OpenAppSettingsUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'openAppSettingsUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$openAppSettingsUseCaseHash();

  @$internal
  @override
  $ProviderElement<OpenAppSettingsUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  OpenAppSettingsUseCase create(Ref ref) {
    return openAppSettingsUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OpenAppSettingsUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OpenAppSettingsUseCase>(value),
    );
  }
}

String _$openAppSettingsUseCaseHash() =>
    r'1f565d177b558d0c80622b4e254ffea680c1112c';
