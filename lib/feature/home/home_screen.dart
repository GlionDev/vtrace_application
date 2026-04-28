import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/design_system/widgets/vtrace_button.dart';
import '../../core/design_system/widgets/vtrace_textfield.dart';
import '../../core/notification/di/notification_module.dart';
import '../../core/notification/di/toast_module.dart';
import 'home_state.dart';
import 'home_viewmodel.dart';

/// 앱의 메인 진입 후 처음 표시되는 홈 화면 위젯입니다.
class HomeScreen extends ConsumerStatefulWidget {
  /// [HomeScreen] 위젯을 생성합니다.
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

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final service = ref.read(sharingIntentServiceProvider);
      final initialText = await service.getInitialSharedText();
      if (!mounted) return;
      if (initialText != null && initialText.isNotEmpty) {
        _applySharedLink(initialText);
      }
    });
  }

  void _applySharedLink(String url) {
    ref.read(homeViewModelProvider.notifier).handleSharedLink(url);
    _linkController.text = url;
    if (_tabController.index != 1) {
      _tabController.animateTo(1);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _linkController.dispose();
    super.dispose();
  }

  Future<void> _onPickFile() async {
    final viewModel = ref.read(homeViewModelProvider.notifier);
    final toast = ref.read(toastServiceProvider);

    final result = await viewModel.pickFile();

    if (result.isSuccess) {
      toast.showInfo('오디오 파일을 선택했습니다.');
      return;
    }
    if (result.isCancelled) {
      toast.showInfo('파일 선택 취소');
      return;
    }
    if (result.isPermanentlyDenied) {
      if (mounted) {
        await _showPermissionDialog();
      }
      viewModel.clearPermissionStatus();
      return;
    }
    if (result.isDenied) {
      toast.showError('해당 기능을 이용하기 위해 권한을 허용해주세요');
      viewModel.clearPermissionStatus();
    }
  }

  Future<void> _showPermissionDialog() async {
    await showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('권한 허용 안내'),
        content: const Text('해당 기능을 이용하기 위해 설정 - VTrace로 이동하여 권한을 허용해주세요.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              ref.read(homeViewModelProvider.notifier).openAppSettings();
            },
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }

  Future<void> _onSeparate() async {
    final homeState = ref.read(homeViewModelProvider);
    final viewModel = ref.read(homeViewModelProvider.notifier);
    final toast = ref.read(toastServiceProvider);

    if (!homeState.canSeparate) {
      toast.showInfo('분리할 파일을 선택해주세요');
      return;
    }
    if (homeState.remainingCredits <= 0) {
      toast.showInfo('사용 한도가 초과되었습니다.');
      return;
    }

    final isSuccess = await viewModel.separate();
    toast.showInfo(isSuccess ? '분리 요청 완료' : '분리 요청 실패');
  }

  @override
  Widget build(BuildContext context) {
    final homeState = ref.watch(homeViewModelProvider);
    final viewModel = ref.read(homeViewModelProvider.notifier);

    ref.listen<AsyncValue<String>>(sharedTextProvider, (previous, next) {
      next.whenData((url) {
        if (url.isNotEmpty) {
          _applySharedLink(url);
        }
      });
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
            Tab(text: '내 파일에서 가져오기'),
            Tab(text: '링크로 가져오기'),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          onPressed: _onPickFile,
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
                        '참고: 다른 앱에서 링크를 공유하여 바로 가져올 수도 있습니다.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsetsDirectional.only(start: 16.0, end: 16.0),
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: VTraceButton(
              text: '분리하기',
              isLoading: homeState.isLoading,
              onPressed: _onSeparate,
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
