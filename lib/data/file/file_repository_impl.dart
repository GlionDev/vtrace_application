import '../../domain/models/file_pick_result.dart';
import '../../domain/repositories/file_repository.dart';
import '../mappers/file_mapper.dart';
import 'file_local_datasource.dart';

/// [FileRepository] 의 구현체입니다.
class FileRepositoryImpl implements FileRepository {
  final FileLocalDataSource _local;

  /// [FileRepositoryImpl] 객체를 생성합니다.
  ///
  /// [local] 파일 처리를 위임할 로컬 데이터소스
  const FileRepositoryImpl(this._local);

  @override
  Future<FilePickResult> pickAudioFile() async {
    final raw = await _local.pickAudioFile();
    return raw.toDomain();
  }

  @override
  Future<bool> openAppSettings() => _local.openAppSettings();
}
