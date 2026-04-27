import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/file/di/file_module.dart';
import '../../../domain/repositories/file_repository.dart';
import '../file_local_datasource.dart';
import '../file_local_datasource_impl.dart';
import '../file_repository_impl.dart';

part 'file_data_module.g.dart';

/// 파일 로컬 데이터소스를 제공합니다.
///
/// 반환값은 [FileLocalDataSource] 의 구현 인스턴스입니다.
@Riverpod(keepAlive: true)
FileLocalDataSource fileLocalDataSource(Ref ref) {
  return FileLocalDataSourceImpl(ref.watch(fileServiceProvider));
}

/// 파일 리포지토리를 제공합니다.
///
/// 반환값은 [FileRepository] 의 구현 인스턴스입니다.
@Riverpod(keepAlive: true)
FileRepository fileRepository(Ref ref) {
  return FileRepositoryImpl(ref.watch(fileLocalDataSourceProvider));
}
