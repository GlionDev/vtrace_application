// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_usecase_module.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 오디오 분리 UseCase 를 제공합니다.
///
/// 반환값은 [SeparateAudioUseCase] 인스턴스입니다.

@ProviderFor(separateAudioUseCase)
final separateAudioUseCaseProvider = SeparateAudioUseCaseProvider._();

/// 오디오 분리 UseCase 를 제공합니다.
///
/// 반환값은 [SeparateAudioUseCase] 인스턴스입니다.

final class SeparateAudioUseCaseProvider
    extends
        $FunctionalProvider<
          SeparateAudioUseCase,
          SeparateAudioUseCase,
          SeparateAudioUseCase
        >
    with $Provider<SeparateAudioUseCase> {
  /// 오디오 분리 UseCase 를 제공합니다.
  ///
  /// 반환값은 [SeparateAudioUseCase] 인스턴스입니다.
  SeparateAudioUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'separateAudioUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$separateAudioUseCaseHash();

  @$internal
  @override
  $ProviderElement<SeparateAudioUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SeparateAudioUseCase create(Ref ref) {
    return separateAudioUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SeparateAudioUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SeparateAudioUseCase>(value),
    );
  }
}

String _$separateAudioUseCaseHash() =>
    r'428cd603728636e748e5937c736e909bcfd3b72f';
