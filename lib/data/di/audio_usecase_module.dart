import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/usecases/separate_audio_usecase.dart';
import '../audio/di/audio_data_module.dart';

part 'audio_usecase_module.g.dart';

/// 오디오 분리 UseCase 를 제공합니다.
///
/// 반환값은 [SeparateAudioUseCase] 인스턴스입니다.
@Riverpod(keepAlive: true)
SeparateAudioUseCase separateAudioUseCase(Ref ref) {
  return SeparateAudioUseCase(ref.watch(audioRepositoryProvider));
}
