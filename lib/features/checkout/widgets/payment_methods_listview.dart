import 'package:flutter/material.dart';
import 'package:payment/core/utils/resources/assets_manager.dart';
import 'package:payment/core/utils/resources/values_manager.dart';
import 'package:payment/features/checkout/widgets/payment_method_item.dart';

class PaymentMethods extends StatefulWidget {
  PaymentMethods({super.key});

  @override
  State<PaymentMethods> createState() => _PaymentMethodsState();
}

class _PaymentMethodsState extends State<PaymentMethods> {
  List<String> paymentItems = [
    IconsAssets.creditIcon,
    ImageAssets.payPalLogo,
    // IconsAssets.applePay,
  ];
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppQuery.height(context, 10),
      child: ListView.builder(
        itemCount: paymentItems.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p12),
            child: GestureDetector(
                onTap: () {
                  setState(() {
                    activeIndex = index;
                  });
                },
                child: PaymentMethodItem(
                    isActive: activeIndex == index,
                    image: paymentItems[index])),
          );
        },
      ),
    );
  }
}
