// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_module.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 파일 시스템 접근을 담당하는 [FileService] 인스턴스를 제공합니다.
///
/// 반환값은 권한 요청 및 파일 선택 처리를 추상화한 서비스 객체입니다.

@ProviderFor(fileService)
final fileServiceProvider = FileServiceProvider._();

/// 파일 시스템 접근을 담당하는 [FileService] 인스턴스를 제공합니다.
///
/// 반환값은 권한 요청 및 파일 선택 처리를 추상화한 서비스 객체입니다.

final class FileServiceProvider
    extends $FunctionalProvider<FileService, FileService, FileService>
    with $Provider<FileService> {
  /// 파일 시스템 접근을 담당하는 [FileService] 인스턴스를 제공합니다.
  ///
  /// 반환값은 권한 요청 및 파일 선택 처리를 추상화한 서비스 객체입니다.
  FileServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fileServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fileServiceHash();

  @$internal
  @override
  $ProviderElement<FileService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  FileService create(Ref ref) {
    return fileService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FileService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FileService>(value),
    );
  }
}

String _$fileServiceHash() => r'392afda264625b54da808877e38c16158ffe4d50';
