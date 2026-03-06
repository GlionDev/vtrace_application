import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_viewmodel.g.dart';

/// 홈 화면의 탭, 상태 등을 관리하는 상태 클래스입니다.
class HomeState {
  final int remainingCredits;
  final int currentTabIndex;
  final String? selectedFilePath;
  final String linkInput;
  final bool isLoading;

  const HomeState({
    this.remainingCredits = 1,
    this.currentTabIndex = 0,
    this.selectedFilePath,
    this.linkInput = '',
    this.isLoading = false,
  });

  HomeState copyWith({
    int? remainingCredits,
    int? currentTabIndex,
    String? selectedFilePath,
    String? linkInput,
    bool? isLoading,
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
    state = state.copyWith(currentTabIndex: index);
  }

  /// 파일 경로 지정 ("내 파일 가져오기"에서 사용)
  void setFilePath(String path) {
    state = state.copyWith(selectedFilePath: path);
  }

  /// 링크 입력 텍스트 업데이트 ("링크로 가져오기"에서 사용)
  void onLinkChanged(String value) {
    state = state.copyWith(linkInput: value);
  }

  /// 링크 분리 로직 모의 (나중에 API 연결)
  Future<void> separateLink() async {
    if (state.linkInput.isEmpty) return;

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
