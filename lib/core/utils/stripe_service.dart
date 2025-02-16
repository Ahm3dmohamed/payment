import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:payment/core/utils/api_keys.dart';
import 'package:payment/core/utils/api_service.dart';
import 'package:payment/features/checkout/data/models/ephemeral_key_model/ephemeral_key_model.dart';
import 'package:payment/features/checkout/data/models/init_payment_sheet_input_model.dart';
import 'package:payment/features/checkout/data/models/payment_intent_input_model.dart';
import 'package:payment/features/checkout/data/models/payment_intent_model/payment_intent_model.dart';

class StripeService {
  final ApiService apiService = ApiService();

  Future<PaymentIntentModel?> _createPaymentIntent(
      PaymentIntentInputModel input) async {
    try {
      var response = await apiService.post(
        body: input.toJson(),
        contentType: Headers.formUrlEncodedContentType,
        url: "https://api.stripe.com/v1/payment_intents",
        token: ApiKeys.secrretKey,
      );
      return PaymentIntentModel.fromJson(response.data);
    } catch (e) {
      print("Stripe PaymentIntent Error: $e");
      return null;
    }
  }

  Future<EphemeralKeyModel?> _createEphemeralKey(String customerId) async {
    try {
      var response = await apiService.post(
        body: {"customer": customerId},
        contentType: Headers.formUrlEncodedContentType,
        url: "https://api.stripe.com/v1/ephemeral_keys",
        token: ApiKeys.secrretKey,
        headers: {
          "Authorization": "Bearer ${ApiKeys.secrretKey}",
          "Stripe-Version": "2025-01-27.acacia"
        },
      );
      return EphemeralKeyModel.fromJson(response.data);
    } catch (e) {
      print("Stripe Ephemeral Key Error: $e");
      return null;
    }
  }

  Future<bool> _initPaymentSheet(PaymentInitSheetInputModel model) async {
    try {
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          merchantDisplayName: 'Ahmed Hamada',
          paymentIntentClientSecret: model.paymentIntentClientSecret,
          customerEphemeralKeySecret: model.ephemeralKeySecret,
          customerId: model.customerId,
        ),
      );
      return true;
    } catch (e) {
      print("Payment Sheet Init Error: $e");
      return false;
    }
  }

  Future<bool> presentPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      return true;
    } catch (e) {
      print("Payment Sheet Error: $e");
      return false;
    }
  }

  Future<bool> doPayment(PaymentIntentInputModel inputModel) async {
    var paymentIntent = await _createPaymentIntent(inputModel);
    if (paymentIntent?.clientSecret == null) return false;

    var ephemeralKey = await _createEphemeralKey(inputModel.customerId);
    if (ephemeralKey?.secret == null) return false;

    var initModel = PaymentInitSheetInputModel(
      paymentIntentClientSecret: paymentIntent!.clientSecret!,
      ephemeralKeySecret: ephemeralKey!.secret!,
      customerId: inputModel.customerId,
    );

    if (!await _initPaymentSheet(initModel)) return false;

    return await presentPaymentSheet();
  }
}
