import 'package:dartz/dartz.dart';
import 'package:payment/core/errors/failures.dart';
import 'package:payment/core/utils/stripe_service.dart';
import 'package:payment/features/checkout/data/models/payment_intent_input_model.dart';
import 'checkout_repo.dart';

class CheckoutRepoImpl extends CheckoutRepo {
  final StripeService stripeService = StripeService();

  @override
  Future<Either<Failure, void>> doPayment({
    required PaymentIntentInputModel paymentIntentInputModel,
  }) async {
    try {
      bool success = await stripeService.doPayment(paymentIntentInputModel);
      if (!success) return Left(ServerFailure(errmessage: "Payment failed."));

      return const Right(null);
    } catch (e) {
      return Left(
          ServerFailure(errmessage: "Unexpected error: ${e.toString()}"));
    }
  }
}
