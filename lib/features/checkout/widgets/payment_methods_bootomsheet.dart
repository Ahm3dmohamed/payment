import 'package:flutter/material.dart';
import 'package:payment/core/resources/values_manager.dart';
import 'package:payment/core/widgets/checkout_button.dart';
import 'package:payment/features/checkout/widgets/payment_methods_listview.dart';

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
          CheckoutButton(
            text: "Continue",
            onPressed: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => const PaymentDetailsView(),
              //     ));
            },
            total: 0,
          ),
        ],
      ),
    );
  }
}
