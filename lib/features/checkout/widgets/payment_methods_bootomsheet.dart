import 'package:flutter/material.dart';
import 'package:payment/core/utils/resources/values_manager.dart';
import 'package:payment/core/widgets/checkout_button.dart';
import 'package:payment/features/checkout/widgets/payment_methods_listview.dart';

import 'custom_button_bloc_consumer.dart';

class PaymentMethodsBottomSheet extends StatelessWidget {
  const PaymentMethodsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          PaymentMethods(),
          const SizedBox(height: AppSize.s16),
          const Spacer(),
          CustomBottonBlocConsumer(),
        ],
      ),
    );
  }
}
