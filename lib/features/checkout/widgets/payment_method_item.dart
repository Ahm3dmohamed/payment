// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:payment/core/resources/color_manager.dart';
import 'package:payment/core/resources/values_manager.dart';

class PaymentMethodItem extends StatelessWidget {
  String image;
  final bool isActive;

  PaymentMethodItem({
    required this.image,
    this.isActive = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 600),
      height: AppQuery.height(context, 12),
      width: AppQuery.width(context, 28),
      decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
            side: BorderSide(
                color: isActive ? ColorManager.darkBlue : Colors.grey,
                width: AppSize.s4),
          ),
          shadows: [
            BoxShadow(
                offset: const Offset(0, 0),
                color: isActive ? const Color(0xff34A853) : Colors.white,
                blurRadius: 2,
                spreadRadius: 0.0),
          ]),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Image.asset(
          image,
          scale: 9,
          fit: BoxFit.scaleDown,
        ),
      ),
    );
  }
}
