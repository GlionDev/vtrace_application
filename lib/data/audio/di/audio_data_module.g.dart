// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_data_module.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 오디오 처리 원격 데이터소스를 제공합니다.
///
/// 반환값은 [AudioRemoteDataSource] 의 구현 인스턴스입니다.

@ProviderFor(audioRemoteDataSource)
final audioRemoteDataSourceProvider = AudioRemoteDataSourceProvider._();

/// 오디오 처리 원격 데이터소스를 제공합니다.
///
/// 반환값은 [AudioRemoteDataSource] 의 구현 인스턴스입니다.

final class AudioRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          AudioRemoteDataSource,
          AudioRemoteDataSource,
          AudioRemoteDataSource
        >
    with $Provider<AudioRemoteDataSource> {
  /// 오디오 처리 원격 데이터소스를 제공합니다.
  ///
  /// 반환값은 [AudioRemoteDataSource] 의 구현 인스턴스입니다.
  AudioRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'audioRemoteDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$audioRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<AudioRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AudioRemoteDataSource create(Ref ref) {
    return audioRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AudioRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AudioRemoteDataSource>(value),
    );
  }
}

String _$audioRemoteDataSourceHash() =>
    r'012a2b1fbe02691233b604c4f542d62490ffd6ac';

/// 오디오 리포지토리를 제공합니다.
///
/// 반환값은 [AudioRepository] 의 구현 인스턴스입니다.

@ProviderFor(audioRepository)
final audioRepositoryProvider = AudioRepositoryProvider._();

/// 오디오 리포지토리를 제공합니다.
///
/// 반환값은 [AudioRepository] 의 구현 인스턴스입니다.

final class AudioRepositoryProvider
    extends
        $FunctionalProvider<AudioRepository, AudioRepository, AudioRepository>
    with $Provider<AudioRepository> {
  /// 오디오 리포지토리를 제공합니다.
  ///
  /// 반환값은 [AudioRepository] 의 구현 인스턴스입니다.
  AudioRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'audioRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$audioRepositoryHash();

  @$internal
  @override
  $ProviderElement<AudioRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AudioRepository create(Ref ref) {
    return audioRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AudioRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AudioRepository>(value),
    );
  }
}

String _$audioRepositoryHash() => r'9b9b6c16f573e3f38ed3186daa1d0d3b34e1dcad';
