// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_data_module.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 파일 로컬 데이터소스를 제공합니다.
///
/// 반환값은 [FileLocalDataSource] 의 구현 인스턴스입니다.

@ProviderFor(fileLocalDataSource)
final fileLocalDataSourceProvider = FileLocalDataSourceProvider._();

/// 파일 로컬 데이터소스를 제공합니다.
///
/// 반환값은 [FileLocalDataSource] 의 구현 인스턴스입니다.

final class FileLocalDataSourceProvider
    extends
        $FunctionalProvider<
          FileLocalDataSource,
          FileLocalDataSource,
          FileLocalDataSource
        >
    with $Provider<FileLocalDataSource> {
  /// 파일 로컬 데이터소스를 제공합니다.
  ///
  /// 반환값은 [FileLocalDataSource] 의 구현 인스턴스입니다.
  FileLocalDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fileLocalDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fileLocalDataSourceHash();

  @$internal
  @override
  $ProviderElement<FileLocalDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FileLocalDataSource create(Ref ref) {
    return fileLocalDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FileLocalDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FileLocalDataSource>(value),
    );
  }
}

String _$fileLocalDataSourceHash() =>
    r'98c78c088b21ff27d0b70a1aae2a69b1f503c23d';

/// 파일 리포지토리를 제공합니다.
///
/// 반환값은 [FileRepository] 의 구현 인스턴스입니다.

@ProviderFor(fileRepository)
final fileRepositoryProvider = FileRepositoryProvider._();

/// 파일 리포지토리를 제공합니다.
///
/// 반환값은 [FileRepository] 의 구현 인스턴스입니다.

final class FileRepositoryProvider
    extends $FunctionalProvider<FileRepository, FileRepository, FileRepository>
    with $Provider<FileRepository> {
  /// 파일 리포지토리를 제공합니다.
  ///
  /// 반환값은 [FileRepository] 의 구현 인스턴스입니다.
  FileRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fileRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fileRepositoryHash();

  @$internal
  @override
  $ProviderElement<FileRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  FileRepository create(Ref ref) {
    return fileRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FileRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FileRepository>(value),
    );
  }
}

String _$fileRepositoryHash() => r'691c53628fd3b8f2628e2679e63df73e3b3e171c';
