import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:payment/features/checkout/data/models/payment_intent_input_model.dart';
import 'package:payment/features/checkout/data/repos/checkout_repo.dart';

part 'payment_cubit_state.dart';

class PaymentCubit extends Cubit<PaymentCubitState> {
  PaymentCubit(this.checkoutRepo)
      : super(
          PaymentInitial(),
        );

  CheckoutRepo checkoutRepo;
  Future doPayment(PaymentIntentInputModel paymentIntentInputModel) async {
    emit(PaymentLoading());
    var data = await checkoutRepo.doPayment(
        paymentIntentInputModel: paymentIntentInputModel);
    data.fold((l) {
      emit(PaymentFailure(l.errmessage));
    }, (r) {
      emit(PaymentSuccess());
    });
  }

  @override
  void onChange(Change<PaymentCubitState> change) {
    log(change.toString());

    super.onChange(change);
  }
}
