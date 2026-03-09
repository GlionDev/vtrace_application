import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../viewmodel/pay_viewmodel.dart';
import '../../../../core/design_system/widgets/vtrace_button.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// 앱 내에서 크레딧 결제를 수행하기 위한 화면입니다.
class PayScreen extends ConsumerWidget {
  const PayScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final payState = ref.watch(payViewModelProvider);
    final viewModel = ref.read(payViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // 기본 뒤로가기 버튼 숨김
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => context.pop(),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                '결제 상품 선택',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),

              // 1000원 상품 (Token 10)
              RadioListTile<String>(
                title: const Text('10 Token'),
                subtitle: const Text('1000원'),
                value: 'token_1000',
                groupValue: payState.selectedProductId,
                onChanged: (value) => viewModel.selectProduct(value!),
              ),

              // 3000원 상품 (Token 35 - 보너스 제공 가정)
              RadioListTile<String>(
                title: const Text('35 Token (베스트)'),
                subtitle: const Text('3000원'),
                value: 'token_3000',
                groupValue: payState.selectedProductId,
                onChanged: (value) => viewModel.selectProduct(value!),
              ),

              // 5000원 상품 (Token 65)
              RadioListTile<String>(
                title: const Text('65 Token'),
                subtitle: const Text('5000원'),
                value: 'token_5000',
                groupValue: payState.selectedProductId,
                onChanged: (value) => viewModel.selectProduct(value!),
              ),

              const Spacer(),

              // 결제하기 버튼
              VTraceButton(
                text: '구매하기',
                isLoading: payState.isLoading,
                onPressed: payState.selectedProductId.isNotEmpty
                    ? () async {
                        try {
                          await viewModel.purchaseSelectedProduct();
                        } catch (e) {
                          Fluttertoast.showToast(
                            msg: "결제 요청 실패: ${e.toString()}",
                          );
                        }
                      }
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
