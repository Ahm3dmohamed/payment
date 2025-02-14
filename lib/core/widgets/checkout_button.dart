import 'package:flutter/material.dart';
import 'package:payment/core/font_manager.dart';
import 'package:payment/core/resources/color_manager.dart';
import 'package:payment/core/resources/values_manager.dart';

// ignore: must_be_immutable
class CheckoutButton extends StatelessWidget {
  CheckoutButton(
      {super.key,
      required this.total,
      required this.text,
      required this.onPressed});
  VoidCallback onPressed;
  final double total;
  String text;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppQuery.width(context, 80),
      // height: AppQuery.height(context, 6), // 6% of screen height
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorManager.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.s12),
            side: const BorderSide(color: ColorManager.textColor, width: 2),
          ),
          padding: EdgeInsets.symmetric(
            vertical: AppQuery.height(context, 1.6), // 2% of screen height
          ),
          elevation: 4,
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: Styles.style22.copyWith(color: Colors.white),
            ),
            SizedBox(width: AppQuery.width(context, 2)),
            const Icon(Icons.payment, color: Colors.white, size: 24),
            SizedBox(width: AppQuery.width(context, 2)),
          ],
        ),
      ),
    );
  }
}
