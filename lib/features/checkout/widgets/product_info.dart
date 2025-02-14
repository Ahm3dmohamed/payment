import 'package:flutter/material.dart';
import 'package:payment/core/font_manager.dart';
import 'package:payment/core/resources/color_manager.dart';
import 'package:payment/core/resources/values_manager.dart';

class ProductInfo extends StatelessWidget {
  const ProductInfo({super.key, required this.price, required this.total});

  final double price;
  final double total;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(AppPadding.p12),
      padding: const EdgeInsets.all(AppPadding.p16),
      decoration: BoxDecoration(
        color: ColorManager.primaryDark,
        borderRadius: BorderRadius.circular(AppSize.s12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.6),
            blurRadius: 6,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow("Discount", "\$0"),
          const Divider(color: Colors.white54, thickness: 1),
          _buildInfoRow("Price", "\$$price"),
          _buildInfoRow("Total", "\$${total.toStringAsFixed(2)}"),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: Styles.style20.copyWith(color: Colors.white)),
          Text(value, style: Styles.style20.copyWith(color: Colors.white)),
        ],
      ),
    );
  }
}
