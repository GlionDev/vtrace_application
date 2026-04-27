import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/usecases/open_app_settings_usecase.dart';
import '../../domain/usecases/pick_audio_file_usecase.dart';
import '../file/di/file_data_module.dart';

part 'file_usecase_module.g.dart';

/// 오디오 파일 선택 UseCase 를 제공합니다.
///
/// 반환값은 [PickAudioFileUseCase] 인스턴스입니다.
@Riverpod(keepAlive: true)
PickAudioFileUseCase pickAudioFileUseCase(Ref ref) {
  return PickAudioFileUseCase(ref.watch(fileRepositoryProvider));
}

/// 시스템 앱 설정 화면 호출 UseCase 를 제공합니다.
///
/// 반환값은 [OpenAppSettingsUseCase] 인스턴스입니다.
@Riverpod(keepAlive: true)
OpenAppSettingsUseCase openAppSettingsUseCase(Ref ref) {
  return OpenAppSettingsUseCase(ref.watch(fileRepositoryProvider));
}
