import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_viewmodel.g.dart';

/// 홈 화면의 탭, 상태 등을 관리하는 상태 클래스입니다.
class HomeState {
  final int remainingCredits;
  final int currentTabIndex;
  final String? selectedFilePath;
  final String linkInput;
  final bool isLoading;
  final String importType;

  const HomeState({
    this.remainingCredits = 1,
    this.currentTabIndex = 0,
    this.selectedFilePath,
    this.linkInput = '',
    this.isLoading = false,
    this.importType = '',
  });

  HomeState copyWith({
    int? remainingCredits,
    int? currentTabIndex,
    String? selectedFilePath,
    String? linkInput,
    bool? isLoading,
    String? importType,
    bool clearFilePath = false,
  }) {
    return HomeState(
      remainingCredits: remainingCredits ?? this.remainingCredits,
      currentTabIndex: currentTabIndex ?? this.currentTabIndex,
      selectedFilePath: clearFilePath
          ? null
          : (selectedFilePath ?? this.selectedFilePath),
      linkInput: linkInput ?? this.linkInput,
      isLoading: isLoading ?? this.isLoading,
      importType: importType ?? this.importType,
    );
  }
}

/// 홈 화면의 사용자 입력 및 로직을 처리하는 뷰모델입니다.
@riverpod
class HomeViewModel extends _$HomeViewModel {
  @override
  HomeState build() {
    return const HomeState();
  }

  /// 탭 인덱스 변경 ("내 파일 가져오기" = 0, "링크로 가져오기" = 1)
  void setTabIndex(int index) {
    state = state.copyWith(
      currentTabIndex: index,
      importType: index == 0
          ? (state.selectedFilePath != null ? 'file' : '')
          : (state.linkInput.isNotEmpty ? 'link' : ''),
    );
  }

  /// 외부에서 들어온 링크를 핸들링하는 함수
  void handleSharedLink(String url) {
    state = state.copyWith(
      linkInput: url,
      currentTabIndex: 1, // 링크 탭으로 강제 이동
      importType: 'link', // 상태 전환
    );
  }

  /// 파일 경로 지정 ("내 파일 가져오기"에서 사용)
  void setFilePath(String path) {
    state = state.copyWith(selectedFilePath: path, importType: 'file');
  }

  /// 링크 입력 텍스트 업데이트 ("링크로 가져오기"에서 사용)
  void onLinkChanged(String value) {
    state = state.copyWith(
      linkInput: value,
      importType: value.isNotEmpty ? 'link' : '',
    );
  }

  /// 분리 요청 처리 로직 (공통)
  Future<void> separateCommon() async {
    if (state.importType.isEmpty) return;

    state = state.copyWith(isLoading: true);
    // 모의 딜레이
    await Future.delayed(const Duration(seconds: 2));

    state = state.copyWith(
      isLoading: false,
      remainingCredits: state.remainingCredits > 0
          ? state.remainingCredits - 1
          : 0,
    );
  }
}
