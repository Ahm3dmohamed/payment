import 'package:flutter/material.dart';

import 'package:payment/core/widgets/build_appbar.dart';
import 'package:payment/features/checkout/presentation/views/payment_details_view_body.dart';

class PaymentDetailsView extends StatelessWidget {
  const PaymentDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: ColorManager.primary,
      appBar: BuildAppBar(
        title: "My Details",
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      body: PaymentDetailsViewBody(),
    );
  }
}
