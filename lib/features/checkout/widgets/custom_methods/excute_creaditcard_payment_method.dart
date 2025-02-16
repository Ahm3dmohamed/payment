import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment/features/checkout/data/models/payment_intent_input_model.dart';
import 'package:payment/features/checkout/presentation/manager/cubit/payment_cubit.dart';

void executeCreditCardPayment(BuildContext context) {
  var paymentIntentInputModel = PaymentIntentInputModel(
    customerId: "cus_RmOzspT2Pefanh",
    amount: "100",
    currency: "USD",
  );
  context.read<PaymentCubit>().doPayment(paymentIntentInputModel);
}
