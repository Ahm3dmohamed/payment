import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment/core/widgets/checkout_button.dart';

import 'package:payment/features/checkout/presentation/manager/cubit/payment_cubit.dart';
import 'package:payment/features/checkout/presentation/views/thanks_you_view.dart';
import 'package:payment/features/checkout/widgets/custom_methods/excute_creaditcard_payment_method.dart';
import 'package:payment/features/checkout/widgets/custom_methods/excute_paypal_payment_method.dart';
import 'package:payment/features/checkout/widgets/custom_methods/get_paypal_transiction_data.dart';
import 'package:payment/features/checkout/widgets/payment_methods_listview.dart';

class CustomBottonBlocConsumer extends StatefulWidget {
  const CustomBottonBlocConsumer({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CustomBottonBlocConsumerState createState() =>
      _CustomBottonBlocConsumerState();
}

class _CustomBottonBlocConsumerState extends State<CustomBottonBlocConsumer> {
  int selectedPaymentMethod = 0; // 0 = Credit Card, 1 = PayPal

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PaymentMethods(
            onMethodSelected: (index) =>
                setState(() => selectedPaymentMethod = index)),
        const SizedBox(height: 10),
        BlocConsumer<PaymentCubit, PaymentCubitState>(
          listener: (context, state) {
            if (state is PaymentSuccess) {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const ThanksYouView()));
            } else if (state is PaymentFailure) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(state.errMessage),
                  backgroundColor: Colors.red));
            }
          },
          builder: (context, state) {
            return CheckoutButton(
              isLoading: state is PaymentLoading,
              text: "Pay Now",
              onPressed: () => selectedPaymentMethod == 0
                  ? executeCreditCardPayment(context)
                  : executePaypalPayment(context, getTransactionData()),
              total: 100,
            );
          },
        ),
      ],
    );
  }
}
