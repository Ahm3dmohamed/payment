import 'package:flutter/material.dart';

import 'package:payment/core/font_manager.dart';
import 'package:payment/core/utils/resources/color_manager.dart';

// ignore: non_constant_identifier_names
AppBar BuildAppBar({required String? title, Function()? onPressed}) {
  return AppBar(
    backgroundColor: ColorManager.primary,
    leading: IconButton(
      onPressed: onPressed,
      icon: const Icon(Icons.arrow_back_ios_new),
    ),
    title:
        Text(title ?? "", style: Styles.style25.copyWith(color: Colors.white)),
    centerTitle: true,
  );
}
