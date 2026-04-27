import '../../domain/models/audio_source.dart';
import '../../domain/repositories/audio_repository.dart';
import 'remote/audio_remote_datasource.dart';

/// [AudioRepository] 의 구현체입니다.
class AudioRepositoryImpl implements AudioRepository {
  final AudioRemoteDataSource _remote;

  /// [AudioRepositoryImpl] 객체를 생성합니다.
  ///
  /// [remote] 오디오 처리 원격 데이터소스
  const AudioRepositoryImpl(this._remote);

  @override
  Future<bool> separate({required AudioSource source}) async {
    switch (source.type) {
      case AudioSourceType.file:
        return _remote.separateFromFile(path: source.filePath ?? '');
      case AudioSourceType.link:
        return _remote.separateFromLink(url: source.linkUrl ?? '');
    }
  }
}
