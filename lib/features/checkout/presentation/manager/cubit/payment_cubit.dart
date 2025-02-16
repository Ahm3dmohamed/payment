import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:payment/core/utils/stripe_service.dart';
import 'package:payment/features/checkout/data/models/payment_intent_input_model.dart';
import 'package:payment/features/checkout/data/repos/checkout_repo.dart';

part 'payment_cubit_state.dart';

class PaymentCubit extends Cubit<PaymentCubitState> {
  PaymentCubit(this.checkoutRepo, this.stripeService) : super(PaymentInitial());

  final CheckoutRepo checkoutRepo;
  final StripeService stripeService;

  Future<void> doPayment(PaymentIntentInputModel inputModel) async {
    emit(PaymentLoading());

    try {
      if (!await stripeService.doPayment(inputModel)) {
        emit(PaymentFailure("Payment process failed."));
        return;
      }

      var data =
          await checkoutRepo.doPayment(paymentIntentInputModel: inputModel);
      data.fold(
        (failure) => emit(PaymentFailure(failure.errmessage)),
        (_) => emit(PaymentSuccess()),
      );
    } catch (e) {
      log("Payment Error: $e");
      emit(PaymentFailure("An error occurred. Please try again."));
    }
  }
}
