import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment/core/widgets/checkout_button.dart';
import 'package:payment/features/checkout/presentation/manager/cubit/payment_cubit_cubit.dart';
import 'package:payment/features/checkout/presentation/views/payment_details_view.dart';
import 'package:payment/features/checkout/presentation/views/thanks_you_view.dart';

class CustomBottonBlocConsumer extends StatelessWidget {
  const CustomBottonBlocConsumer({
    super.key,
  });

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
            ),
          );
        }
      },
      builder: (context, state) {
        return CheckoutButton(
          isLoading: state is PaymentLoading ? true : false,
          text: "Continue",
          onPressed: () {},
          total: 0,
        );
      },
    );
  }
}
