import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/design_system/widgets/vtrace_button.dart';
import '../../core/notification/di/toast_module.dart';
import '../../domain/models/credit_product.dart';
import 'pay_state.dart';
import 'pay_viewmodel.dart';

/// 앱 내에서 크레딧 결제를 수행하기 위한 화면입니다.
class PayScreen extends ConsumerWidget {
  /// [PayScreen] 위젯을 생성합니다.
  const PayScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final payState = ref.watch(payViewModelProvider);
    final viewModel = ref.read(payViewModelProvider.notifier);

    ref.listen<PayState>(payViewModelProvider, (previous, next) {
      if (next.message != null &&
          next.message!.isNotEmpty &&
          next.status != PayStatus.idle &&
          previous?.message != next.message) {
        final toast = ref.read(toastServiceProvider);
        if (next.status == PayStatus.failure) {
          toast.showError(next.message!);
        } else {
          toast.showInfo(next.message!);
        }
        viewModel.clearMessage();
      }
    });

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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

              ...payState.products.map(
                (product) => _ProductTile(
                  product: product,
                  groupValue: payState.selectedProductId,
                  onChanged: (value) => viewModel.selectProduct(value!),
                ),
              ),

              const Spacer(),

              VTraceButton(
                text: '구매하기',
                isLoading: payState.isLoading,
                onPressed: payState.selectedProductId.isNotEmpty
                    ? viewModel.purchaseSelectedProduct
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProductTile extends StatelessWidget {
  const _ProductTile({
    required this.product,
    required this.groupValue,
    required this.onChanged,
  });

  final CreditProduct product;
  final String groupValue;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    final title = product.badge != null
        ? '${product.title} (${product.badge})'
        : product.title;
    return RadioListTile<String>(
      title: Text(title),
      subtitle: Text(product.priceLabel),
      value: product.id,
      groupValue: groupValue,
      onChanged: onChanged,
    );
  }
}
