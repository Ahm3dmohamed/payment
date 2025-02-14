// ✅ Widget مستقلة لعرض صورة المنتج
import 'package:flutter/material.dart';
import 'package:payment/core/utils/resources/assets_manager.dart';
import 'package:payment/core/utils/resources/values_manager.dart';

class ProductImage extends StatelessWidget {
  const ProductImage({super.key, required this.size});

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(Appmargin.m16),
      height: size.height * 0.38,
      width: size.width,
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage(ImageAssets.productImage),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
