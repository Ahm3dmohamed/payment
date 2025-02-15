import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:payment/core/utils/resources/values_manager.dart';
import 'package:payment/core/widgets/checkout_button.dart';
import 'package:payment/features/checkout/presentation/views/thanks_you_view.dart';
import 'package:payment/features/checkout/widgets/custom_credit_card.dart';
import 'package:payment/features/checkout/widgets/payment_methods_listview.dart';

class PaymentDetailsViewBody extends StatefulWidget {
  PaymentDetailsViewBody({super.key});

  @override
  State<PaymentDetailsViewBody> createState() => _PaymentDetailsViewBodyState();
}

class _PaymentDetailsViewBodyState extends State<PaymentDetailsViewBody> {
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p5),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: PaymentMethods()),
          // SliverToBoxAdapter(
          //     child: CustomCreditCard(
          //   formKey: formKey,
          //   autovalidateMode: autovalidateMode,
          // )),
          SliverFillRemaining(
              fillOverscroll: false,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: CheckoutButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                    } else {
                      autovalidateMode = AutovalidateMode.always;
                      setState(() {});
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ThanksYouView(),
                      ));
                    }
                  },
                  text: "Pay",
                  total: 0,
                ),
              )),
        ],
      ),
    );
  }
}
