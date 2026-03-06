import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 앱의 메인 진입 후 처음 표시되는 홈 화면 위젯입니다.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('VTrace Home')),
      body: const Center(child: Text('Home Screen (Skeleton)')),
    );
  }
}
