import '../../core/file/file_service.dart';
import 'file_local_datasource.dart';

/// [FileLocalDataSource] 의 [FileService] 기반 구현체입니다.
class FileLocalDataSourceImpl implements FileLocalDataSource {
  final FileService _fileService;

  /// [FileLocalDataSourceImpl] 객체를 생성합니다.
  ///
  /// [fileService] 권한 + 파일 선택 처리를 담당하는 코어 서비스
  const FileLocalDataSourceImpl(this._fileService);

  @override
  Future<FilePickRawResult> pickAudioFile() => _fileService.pickAudioFile();

  @override
  Future<bool> openAppSettings() => _fileService.openSettings();
}
