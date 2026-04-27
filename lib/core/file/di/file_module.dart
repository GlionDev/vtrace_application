import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../file_service.dart';

part 'file_module.g.dart';

/// 파일 시스템 접근을 담당하는 [FileService] 인스턴스를 제공합니다.
///
/// 반환값은 권한 요청 및 파일 선택 처리를 추상화한 서비스 객체입니다.
@Riverpod(keepAlive: true)
FileService fileService(Ref ref) {
  return FileService();
}
