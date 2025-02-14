import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:payment/core/utils/api_keys.dart';
import 'package:payment/core/utils/api_service.dart';
import 'package:payment/features/checkout/data/models/payment_intent_input_model.dart';
import 'package:payment/features/checkout/data/models/payment_intent_model/payment_intent_model.dart';

class StripeService {
  final ApiService apiService = ApiService();
  Future<PaymentIntentModel> createPaymentIntent(
      PaymentIntentInputModel paymentIntentInputModel) async {
    var responce = await apiService.post(
        body: paymentIntentInputModel.toJson,
        url: "https://api.stripe.com/v1/payment_intents",
        token: ApiKeys.secrretKey);
    var paymentIntentModel = PaymentIntentModel.fromJson(responce.data);
    return paymentIntentModel;
    // static String getPublishableKey() {
    //   return 'pk_test_51J3ZQvK5';
    // }
    // static String getSecretKey() {
    //   return 'sk_test_51J3ZQvK5';
    // }
    // static String getPaymentUrl() {
    //   return 'https://api.stripe.com/v1/payment_intents';
    // }
    // static String getPaymentMethodUrl() {
    //   return 'https://api.stripe.com/v1/payment_methods';
    // }
    // static String getSecretPaymentUrl() {
    //   return 'https://api.stripe.com/v1/payment_intents/';
    // }
    // static String getSecretPaymentMethodUrl() {
    //   return 'https://api.stripe.com/v1/payment_methods/';
    // }
    // static String getPaymentIntentUrl() {
    //   return 'https://api.stripe.com/v1/payment_intents/';
    // }
    // static String getPaymentIntentCaptureUrl() {
    //   return 'https://api.stripe.com/v1/payment_intents/';
    // }
    // static String getPaymentIntentConfirmUrl() {
    //   return 'https://api.stripe.com/v1/payment_intents/';
    // }
    // static String getPaymentIntentCancelUrl() {
    //   return 'https://api.stripe.com/v1/payment_intents/';
    // }
    // static String getPaymentIntentRetrieveUrl() {
    //   return 'https://api.stripe.com/v1/payment_intents/';
    // }
  }

  Future initPaymentSheet({required String paymentIntentClientSecret}) async {
    Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        // Main params
        merchantDisplayName: 'Ahmed Hamada',
        paymentIntentClientSecret: paymentIntentClientSecret,
      ),
    );
  }
}
