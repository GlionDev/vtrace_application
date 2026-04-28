/// 홈 화면의 가져오기 소스 타입을 나타냅니다.
enum HomeImportType {
  /// 가져오기 미선택 상태
  none,

  /// 기기 내 파일에서 가져오기
  file,

  /// 외부 링크에서 가져오기
  link,
}

/// 홈 화면의 권한 안내 상태를 나타냅니다.
enum HomePermissionStatus {
  /// 별도 안내가 필요 없는 상태
  none,

  /// 일시 거부된 상태(토스트 안내)
  denied,

  /// 영구 거부된 상태(설정 화면 안내 다이얼로그)
  permanentlyDenied,
}

/// 홈 화면의 탭/입력/로딩 등을 관리하는 상태 클래스입니다.
class HomeState {
  /// 남은 무료 사용 횟수
  final int remainingCredits;

  /// 현재 선택된 탭 인덱스
  final int currentTabIndex;

  /// 선택된 파일의 경로
  final String? selectedFilePath;

  /// 입력된 링크 텍스트
  final String linkInput;

  /// 분리/파일 가져오기 로딩 여부
  final bool isLoading;

  /// 현재 가져오기 소스 타입
  final HomeImportType importType;

  /// 권한 안내 처리 상태
  final HomePermissionStatus permissionStatus;

  /// [HomeState] 객체를 생성합니다.
  const HomeState({
    this.remainingCredits = 1,
    this.currentTabIndex = 0,
    this.selectedFilePath,
    this.linkInput = '',
    this.isLoading = false,
    this.importType = HomeImportType.none,
    this.permissionStatus = HomePermissionStatus.none,
  });

  /// 가져오기 소스가 지정되어 분리 버튼을 활성화할 수 있는지 여부입니다.
  bool get canSeparate => importType != HomeImportType.none;

  /// 기존 상태를 복사하여 일부 값만 변경한 새로운 인스턴스를 반환합니다.
  ///
  /// [clearFilePath] 가 true 이면 [selectedFilePath] 를 null 로 초기화합니다.
  /// 반환값은 새로 생성된 [HomeState] 객체입니다.
  HomeState copyWith({
    int? remainingCredits,
    int? currentTabIndex,
    String? selectedFilePath,
    String? linkInput,
    bool? isLoading,
    HomeImportType? importType,
    HomePermissionStatus? permissionStatus,
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
      permissionStatus: permissionStatus ?? this.permissionStatus,
    );
  }
}
