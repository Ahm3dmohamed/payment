import 'package:flutter/material.dart';
import 'package:payment/core/font_manager.dart';
import 'package:payment/core/resources/color_manager.dart';
import 'package:payment/core/resources/values_manager.dart';

class CustomBarcodePaidShow extends StatelessWidget {
  const CustomBarcodePaidShow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Flexible(
          child: ImageIcon(
            size: 100,
            const AssetImage("assets/images/code.png"),
            color: ColorManager.black,
          ),
        ),
        const SizedBox(width: AppSize.s35),
        Flexible(
          child: Container(
            height: AppQuery.height(context, 7),
            width: AppQuery.width(context, 40),
            decoration: ShapeDecoration(
              color: const Color(0xffD9D9D9),
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                    color: Color.fromARGB(255, 6, 161, 11), width: 1.5),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: Center(
              child: Text(
                "PAID",
                style: Styles.style16.copyWith(
                  color: const Color.fromARGB(255, 6, 161, 11),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
