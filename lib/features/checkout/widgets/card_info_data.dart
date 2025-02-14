import 'package:flutter/material.dart';
import 'package:payment/core/font_manager.dart';
import 'package:payment/core/utils/resources/assets_manager.dart';
import 'package:payment/core/utils/resources/values_manager.dart';

class CardInfoWidget extends StatelessWidget {
  const CardInfoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: AppSize.s35,
      ),
      height: AppQuery.height(context, 10),
      width: AppQuery.width(context, 80),
      decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          )),
      child: Row(
        children: [
          Image.asset(ImageAssets.master),
          Text.rich(TextSpan(children: [
            TextSpan(
              text: "**** **** **** ",
              style: Styles.style16
                  .copyWith(color: const Color.fromARGB(255, 65, 62, 62)),
            ),
            TextSpan(
              text: "1234",
              style: Styles.style16
                  .copyWith(color: const Color.fromARGB(255, 65, 62, 62)),
            ),
          ])),
        ],
      ),
    );
  }
}
