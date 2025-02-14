import 'package:dartz/dartz.dart';
import 'package:payment/core/errors/failures.dart';
import 'package:payment/core/utils/stripe_service.dart';
import 'package:payment/features/checkout/data/models/payment_intent_input_model.dart';

import 'checkout_repo.dart';

class CheckoutRepoImpl extends CheckoutRepo {
  final StripeService stripeService = StripeService();

  @override
  Future<Either<Failure, void>> doPayment(
      {required PaymentIntentInputModel paymentIntentInputModel}) async {
    try {
      stripeService.doPayment(paymentIntentInputModel: paymentIntentInputModel);
      return Right(null);
    } catch (e) {
      return left(ServerFailure(errmessage: e.toString()));
    }
  }
}
