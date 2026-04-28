import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/di/audio_usecase_module.dart';
import '../../data/di/file_usecase_module.dart';
import '../../domain/models/audio_source.dart';
import '../../domain/models/file_pick_result.dart';
import 'home_state.dart';

part 'home_viewmodel.g.dart';

/// 홈 화면의 사용자 입력 및 비즈니스 로직을 처리하는 뷰모델입니다.
@riverpod
class HomeViewModel extends _$HomeViewModel {
  @override
  HomeState build() {
    return const HomeState();
  }

  /// 탭 인덱스를 변경합니다.
  ///
  /// [index] 새로 선택된 탭 인덱스 (0: 파일 가져오기, 1: 링크 가져오기)
  void setTabIndex(int index) {
    state = state.copyWith(
      currentTabIndex: index,
      importType: index == 0
          ? (state.selectedFilePath != null
                ? HomeImportType.file
                : HomeImportType.none)
          : (state.linkInput.isNotEmpty
                ? HomeImportType.link
                : HomeImportType.none),
    );
  }

  /// 외부에서 들어온 공유 링크를 처리합니다.
  ///
  /// [url] 외부 앱에서 전달받은 공유 URL
  void handleSharedLink(String url) {
    state = state.copyWith(
      linkInput: url,
      currentTabIndex: 1,
      importType: HomeImportType.link,
    );
  }

  /// 링크 입력 텍스트가 변경될 때 호출됩니다.
  ///
  /// [value] 변경된 링크 텍스트
  void onLinkChanged(String value) {
    state = state.copyWith(
      linkInput: value,
      importType: value.isNotEmpty
          ? HomeImportType.link
          : HomeImportType.none,
    );
  }

  /// 권한 안내 상태를 초기화합니다.
  ///
  /// 화면이 안내(토스트/다이얼로그)를 처리한 뒤 호출하여
  /// 동일한 안내가 반복되지 않게 합니다.
  void clearPermissionStatus() {
    state = state.copyWith(permissionStatus: HomePermissionStatus.none);
  }

  /// 오디오 파일 선택을 시도합니다.
  ///
  /// 권한 거부/취소 등의 결과는 상태로 반영되며,
  /// 반환값은 선택 결과를 담은 [FilePickResult] 객체입니다.
  Future<FilePickResult> pickFile() async {
    final useCase = ref.read(pickAudioFileUseCaseProvider);
    final result = await useCase();

    if (result.isSuccess) {
      state = state.copyWith(
        selectedFilePath: result.path,
        importType: HomeImportType.file,
        permissionStatus: HomePermissionStatus.none,
      );
    } else if (result.isPermanentlyDenied) {
      state = state.copyWith(
        permissionStatus: HomePermissionStatus.permanentlyDenied,
      );
    } else if (result.isDenied) {
      state = state.copyWith(permissionStatus: HomePermissionStatus.denied);
    }
    return result;
  }

  /// 시스템 앱 설정 화면을 엽니다.
  ///
  /// 반환값은 설정 화면 호출 성공 여부입니다.
  Future<bool> openAppSettings() {
    final useCase = ref.read(openAppSettingsUseCaseProvider);
    return useCase();
  }

  /// 분리 요청을 수행합니다.
  ///
  /// 현재 [HomeState.importType] 에 따라 파일/링크 소스로 분기하여
  /// [SeparateAudioUseCase] 를 호출합니다.
  /// 반환값은 분리 처리 성공 여부입니다.
  Future<bool> separate() async {
    if (!state.canSeparate) return false;
    if (state.remainingCredits <= 0) return false;

    final source = switch (state.importType) {
      HomeImportType.file => AudioSource.fromFile(state.selectedFilePath ?? ''),
      HomeImportType.link => AudioSource.fromLink(state.linkInput),
      HomeImportType.none => null,
    };
    if (source == null) return false;

    state = state.copyWith(isLoading: true);
    try {
      final useCase = ref.read(separateAudioUseCaseProvider);
      final isSuccess = await useCase(source: source);

      state = state.copyWith(
        isLoading: false,
        remainingCredits: isSuccess
            ? state.remainingCredits - 1
            : state.remainingCredits,
      );
      return isSuccess;
    } catch (_) {
      state = state.copyWith(isLoading: false);
      return false;
    }
  }
}
