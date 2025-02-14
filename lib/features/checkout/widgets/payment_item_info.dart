import 'package:flutter/material.dart';
import 'package:payment/core/font_manager.dart';
import 'package:payment/core/resources/values_manager.dart';

class PaymentItemInfo extends StatelessWidget {
  String text, textInfo;
  PaymentItemInfo({required this.text, required this.textInfo, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: Styles.style16
              .copyWith(color: const Color.fromARGB(255, 37, 36, 36)),
          textAlign: TextAlign.center,
        ),
        const Spacer(),
        Text(
          textInfo,
          style: Styles.style16
              .copyWith(color: const Color.fromARGB(255, 37, 36, 36)),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: AppSize.s18,
        ),
      ],
    );
  }
}
