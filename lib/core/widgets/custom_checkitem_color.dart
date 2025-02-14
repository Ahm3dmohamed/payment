import 'package:flutter/material.dart';
import 'package:payment/core/utils/resources/values_manager.dart';

class CustomCheckItem extends StatelessWidget {
  const CustomCheckItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: AppSize.s50,
      backgroundColor: Color(0xffD9D9D9),
      child: CircleAvatar(
        backgroundColor: Colors.green,
        radius: AppSize.s35,
        child: Icon(
          Icons.check,
          color: Colors.white,
          size: 50,
        ),
      ),
    );
  }
}
