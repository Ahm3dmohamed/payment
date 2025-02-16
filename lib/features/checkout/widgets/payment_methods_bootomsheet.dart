import 'package:flutter/material.dart';

import 'custom_button_bloc_consumer.dart';

class PaymentMethodsBottomSheet extends StatelessWidget {
  const PaymentMethodsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          Spacer(),
          CustomBottonBlocConsumer(),
        ],
      ),
    );
  }
}
