import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/repositories/audio_repository.dart';
import '../audio_repository_impl.dart';
import '../remote/audio_remote_datasource.dart';
import '../remote/audio_remote_datasource_impl.dart';

part 'audio_data_module.g.dart';

/// 오디오 처리 원격 데이터소스를 제공합니다.
///
/// 반환값은 [AudioRemoteDataSource] 의 구현 인스턴스입니다.
@Riverpod(keepAlive: true)
AudioRemoteDataSource audioRemoteDataSource(Ref ref) {
  return const AudioRemoteDataSourceImpl();
}

/// 오디오 리포지토리를 제공합니다.
///
/// 반환값은 [AudioRepository] 의 구현 인스턴스입니다.
@Riverpod(keepAlive: true)
AudioRepository audioRepository(Ref ref) {
  return AudioRepositoryImpl(ref.watch(audioRemoteDataSourceProvider));
}
