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

  Future<void> doPayment(
      PaymentIntentInputModel paymentIntentInputModel) async {
    emit(PaymentLoading());

    try {
      // 1️⃣ Create a PaymentIntent using Stripe API
      var paymentIntent =
          await stripeService.createPaymentIntent(paymentIntentInputModel);
      if (paymentIntent == null || paymentIntent.clientSecret == null) {
        emit(PaymentFailure("Failed to create payment intent."));
        return;
      }

      // 2️⃣ Initialize Stripe Payment Sheet
      bool initSuccess = await stripeService.initPaymentSheet(
        paymentIntentClientSecret: paymentIntent.clientSecret!,
      );
      if (!initSuccess) {
        emit(PaymentFailure("Failed to initialize Stripe Payment Sheet."));
        return;
      }

      // 3️⃣ Present the Stripe Payment Sheet to user
      bool paymentSuccess = await stripeService.presentPaymentSheet();
      if (!paymentSuccess) {
        emit(PaymentFailure("Payment was not completed."));
        return;
      }

      // 4️⃣ Call your backend to confirm payment (if needed)
      var data = await checkoutRepo.doPayment(
          paymentIntentInputModel: paymentIntentInputModel);
      data.fold(
        (failure) {
          log("Payment failed: ${failure.errmessage}");
          emit(PaymentFailure(failure.errmessage));
        },
        (success) {
          log("Payment successful! Navigating to Thank You View...");
          emit(PaymentSuccess());
        },
      );
    } catch (e, stackTrace) {
      log("Unexpected error during payment: $e", stackTrace: stackTrace);
      emit(PaymentFailure("An unexpected error occurred. Please try again."));
    }
  }
}
