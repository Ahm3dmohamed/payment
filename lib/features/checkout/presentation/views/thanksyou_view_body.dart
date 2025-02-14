import 'package:flutter/material.dart';
import 'package:payment/core/utils/resources/values_manager.dart';
import 'package:payment/core/widgets/custom_checkitem_color.dart';
import 'package:payment/core/widgets/custom_dashedline.dart';
import 'package:payment/features/checkout/widgets/thankyou_card.dart';

class ThanksyouViewBody extends StatelessWidget {
  const ThanksyouViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: ColorManager.primaryDark,
      body: Padding(
        padding: const EdgeInsets.only(
          left: AppPadding.p25,
          right: AppPadding.p25,
          bottom: AppPadding.p30,
          top: AppPadding.p35 + 60,
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            const ThankYouCard(),
            Positioned(
              left: 20 + 8,
              right: 20 + 8,
              bottom: AppQuery.height(context, 21),
              child: const CustomDashedLine(),
            ),
            Positioned(
                left: -20,
                bottom: AppQuery.height(context, 19),
                child: const CircleAvatar(
                  backgroundColor: Colors.white,
                )),
            Positioned(
                right: -20,
                bottom: AppQuery.height(context, 19),
                child: const CircleAvatar(
                  backgroundColor: Colors.white,
                )),
            const Positioned(
                top: -50, right: 0, left: 0, child: CustomCheckItem()),
          ],
        ),
      ),
    );
  }
}
