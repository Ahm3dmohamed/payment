import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment/core/widgets/checkout_button.dart';
import 'package:payment/features/checkout/data/models/payment_intent_input_model.dart';
import 'package:payment/features/checkout/presentation/manager/cubit/payment_cubit.dart';
import 'package:payment/features/checkout/presentation/views/thanks_you_view.dart';

class CustomBottonBlocConsumer extends StatelessWidget {
  const CustomBottonBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentCubit, PaymentCubitState>(
      listener: (context, state) {
        if (state is PaymentSuccess) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const ThanksYouView(),
            ),
          );
        } else if (state is PaymentFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errMessage),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        return CheckoutButton(
          isLoading: state is PaymentLoading,
          text: "Continue",
          onPressed: () {
            PaymentIntentInputModel paymentIntentInputModel =
                PaymentIntentInputModel(
              amount: "100",
              currency: "USD",
            );

            BlocProvider.of<PaymentCubit>(context)
                .doPayment(paymentIntentInputModel);
          },
          total: 100,
        );
      },
    );
  }
}
