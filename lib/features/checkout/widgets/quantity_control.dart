import 'package:flutter/material.dart';
import 'package:payment/core/font_manager.dart';
import 'package:payment/core/resources/color_manager.dart';
import 'package:payment/core/resources/values_manager.dart';

class QuantityControls extends StatelessWidget {
  const QuantityControls({
    super.key,
    required this.quantity,
    required this.onIncrease,
    required this.onDecrease,
  });

  final int quantity;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _quantityButton(Icons.remove, onDecrease),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSize.s12),
          child: Text(
            '$quantity',
            style: Styles.style25.copyWith(color: ColorManager.primaryDark),
          ),
        ),
        _quantityButton(Icons.add, onIncrease),
      ],
    );
  }

  Widget _quantityButton(IconData icon, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 45,
        width: 45,
        decoration: BoxDecoration(
          color: ColorManager.primary,
          borderRadius: BorderRadius.circular(AppSize.s8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 24,
        ),
      ),
    );
  }
}
