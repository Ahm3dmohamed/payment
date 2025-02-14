import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:payment/core/font_manager.dart';
import 'package:payment/core/utils/resources/assets_manager.dart';
import 'package:payment/core/utils/resources/color_manager.dart';
import 'package:payment/core/utils/resources/values_manager.dart';
import 'package:payment/features/checkout/widgets/card_info_data.dart';
import 'package:payment/features/checkout/widgets/custom_barcode_paid_show.dart';
import 'package:payment/features/checkout/widgets/payment_item_info.dart';

class ThankYouCard extends StatelessWidget {
  const ThankYouCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppQuery.width(context, 85),
      decoration: ShapeDecoration(
          color: const Color(0xffD9D9D9),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          )),
      child: Padding(
        padding: const EdgeInsets.only(
          top: AppPadding.p35 + 15,
          left: AppPadding.p25,
          right: AppPadding.p25,
        ),
        child: Column(
          children: [
            Text(
              "Thank You!",
              style: Styles.style20,
              textAlign: TextAlign.center,
            ),
            Text(
              " Your Transiction was successfull",
              style: Styles.style16
                  .copyWith(color: const Color.fromARGB(255, 65, 62, 62)),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: AppSize.s20,
            ),
            PaymentItemInfo(text: "Date", textInfo: "13/2/2025"),
            const SizedBox(
              height: AppSize.s10,
            ),
            PaymentItemInfo(text: "Time", textInfo: "10:24 pm"),
            const SizedBox(
              height: AppSize.s10,
            ),
            PaymentItemInfo(text: "To", textInfo: "Ahmed"),
            const SizedBox(
              height: AppSize.s18,
            ),
            const Divider(
              thickness: 2,
            ),
            const SizedBox(
              height: AppSize.s18,
            ),
            PaymentItemInfo(text: "Total", textInfo: r"$50.45"),
            const CardInfoWidget(),
            const Spacer(),
            const CustomBarcodePaidShow(),
            SizedBox(
              height: (AppQuery.height(context, 24 / 4.5)) - 15,
            ),
          ],
        ),
      ),
    );
  }
}
