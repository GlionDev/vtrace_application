import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../viewmodel/home_viewmodel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../core/design_system/widgets/vtrace_textfield.dart';
import '../../../../core/design_system/widgets/vtrace_button.dart';
import '../../../../main.dart'; // sharedTextProvider 접근용

/// 앱의 메인 진입 후 처음 표시되는 홈 화면 위젯입니다.
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _linkController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        ref
            .read(homeViewModelProvider.notifier)
            .setTabIndex(_tabController.index);
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final initialText = ref.read(sharedTextProvider);
      if (initialText != null && initialText.isNotEmpty) {
        ref.read(homeViewModelProvider.notifier).handleSharedLink(initialText);
        _linkController.text = initialText;
        if (_tabController.index != 1) {
          _tabController.animateTo(1);
        }
        ref.read(sharedTextProvider.notifier).setSharedText(null);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _linkController.dispose();
    super.dispose();
  }

  Future<void> _pickFile() async {
    // 2-1. 가져오기 눌렀을때 파일 가져오는것 관련 권한 요청
    // (Android 버전에 대응하기 위해 storage와 audio 모두 고려)
    var storageStatus = await Permission.storage.status;
    var audioStatus = await Permission.audio.status;

    if (!storageStatus.isGranted && !audioStatus.isGranted) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.storage,
        Permission.audio,
      ].request();

      storageStatus = statuses[Permission.storage] ?? PermissionStatus.denied;
      audioStatus = statuses[Permission.audio] ?? PermissionStatus.denied;
    }

    bool isGranted = storageStatus.isGranted || audioStatus.isGranted;

    if (!isGranted) {
      // 2-3. 여러번 거부한 뒤 "가져오기" 눌렀을 경우 Dialog 띄워서 권한 허용 안내
      if (storageStatus.isPermanentlyDenied ||
          audioStatus.isPermanentlyDenied) {
        _showPermissionDialog();
      } else {
        // 2-2. 권한 거부 시 Toast 메시지 출력
        Fluttertoast.showToast(msg: "해당 기능을 이용하기 위해 권한을 허용해주세요");
      }
      return;
    }

    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.audio,
      );

      if (result != null && result.files.single.path != null) {
        ref
            .read(homeViewModelProvider.notifier)
            .setFilePath(result.files.single.path!);
        Fluttertoast.showToast(msg: "오디오 파일을 선택했습니다.");
      } else {
        Fluttertoast.showToast(msg: "파일 선택 취소");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "파일 가져오기 오류: $e");
    }
  }

  void _showPermissionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("권한 허용 안내"),
        content: const Text("해당 기능을 이용하기 위해 설정 - VTrace로 이동하여 권한을 허용해주세요."),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("취소"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              openAppSettings();
            },
            child: const Text("확인"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final homeState = ref.watch(homeViewModelProvider);
    final viewModel = ref.read(homeViewModelProvider.notifier);

    // 글로벌으로 주입되는 공유 링크(sharedTextProvider)가 변경될 때 대응하여 ViewModel 및 UI 갱신
    ref.listen<String?>(sharedTextProvider, (previous, next) {
      if (next != null && next.isNotEmpty) {
        viewModel.handleSharedLink(next);
        _linkController.text = next;
        // 링크 수신 후 즉시 탭 1번으로 전환
        if (_tabController.index != 1) {
          _tabController.animateTo(1);
        }
        ref.read(sharedTextProvider.notifier).setSharedText(null); // 처리 후 소거
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('VTrace Home'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(
              child: GestureDetector(
                onTap: () {
                  context.push('/pay');
                },
                child: Text(
                  homeState.remainingCredits <= 0
                      ? '크레딧을 추가하세요'
                      : '무료 횟수: ${homeState.remainingCredits} / 1',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: "내 파일에서 가져오기"),
            Tab(text: "링크로 가져오기"),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // 탭 1: 내 파일에서 가져오기
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          onPressed: _pickFile,
                          icon: const Icon(Icons.file_upload),
                          label: const Text('파일 가져오기 (Audio)'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 16,
                            ),
                            textStyle: const TextStyle(fontSize: 18),
                          ),
                        ),
                        const SizedBox(height: 16),
                        if (homeState.selectedFilePath != null)
                          Text(
                            '선택된 파일: ${homeState.selectedFilePath!.split('/').last}',
                          ),
                      ],
                    ),
                  ),
                ),

                // 탭 2: 링크로 가져오기
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      VTraceTextField(
                        controller: _linkController,
                        hintText: 'https:// 링크를 입력하세요',
                        onChanged: viewModel.onLinkChanged,
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        '참고: 다른 앱에서 링크를 공유하여 바로 가져올 수도 있습니다.\n(해당 기능은 추후 추가 예정)',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // 하단 공통 분리하기 버튼
          Container(
            width: double.infinity,
            margin: const EdgeInsetsDirectional.only(start: 16.0, end: 16.0),
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: VTraceButton(
              text: '분리하기',
              isLoading: homeState.isLoading,
              onPressed: homeState.importType.isNotEmpty
                  ? () async {
                      if (homeState.remainingCredits <= 0) {
                        Fluttertoast.showToast(msg: "사용 한도가 초과되었습니다.");
                        return;
                      }
                      await viewModel.separateCommon();
                      Fluttertoast.showToast(msg: "분리 요청 완료");
                    }
                  : () {
                      Fluttertoast.showToast(msg: "분리할 파일을 선택해주세요");
                    },
            ),
          ),
          const SizedBox(height: 16), // SafeArea 하단 여백 대비
        ],
      ),
    );
  }
}
