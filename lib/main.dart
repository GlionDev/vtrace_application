import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharing_intent/flutter_sharing_intent.dart';
import 'package:flutter_sharing_intent/model/sharing_file.dart';
import 'core/common/logger/app_logger.dart';
import 'router/app_router.dart';
import 'dart:async';

String? initialSharedText;

class SharedTextNotifier extends Notifier<String?> {
  @override
  String? build() => initialSharedText;

  void setSharedText(String? text) {
    state = text;
  }
}

/// 앱 시작 시 외부로부터 공유받은 초기 텍스트(URL 등)를 저장하는 전역 프로바이더
final sharedTextProvider = NotifierProvider<SharedTextNotifier, String?>(
  SharedTextNotifier.new,
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppLogger.init();

  // 앱이 완전히 종료된 상태에서 공유받아 실행될 때의 처리
  try {
    final List<SharedFile> initialMedia = await FlutterSharingIntent.instance
        .getInitialSharing();
    if (initialMedia.isNotEmpty &&
        (initialMedia.first.type == SharedMediaType.TEXT ||
            initialMedia.first.type == SharedMediaType.URL)) {
      initialSharedText = initialMedia.first.value;
    }
  } catch (e) {
    final logger = AppLogger.getLogger('main');
    logger.severe('Failed to get initial shared media: $e');
  }

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  late StreamSubscription _intentDataStreamSubscription;

  @override
  void initState() {
    super.initState();
    // 앱이 메모리에 올라와 있거나 백그라운드에 있을 때 공유받는 스트림 리스너
    _intentDataStreamSubscription = FlutterSharingIntent.instance
        .getMediaStream()
        .listen(
          (List<SharedFile> value) {
            if (value.isNotEmpty &&
                (value.first.type == SharedMediaType.TEXT ||
                    value.first.type == SharedMediaType.URL)) {
              ref
                  .read(sharedTextProvider.notifier)
                  .setSharedText(value.first.value);
            }
          },
          onError: (err) {
            final logger = AppLogger.getLogger('MyApp');
            logger.severe('getMediaStream error: $err');
          },
        );
  }

  @override
  void dispose() {
    _intentDataStreamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'VTrace',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
