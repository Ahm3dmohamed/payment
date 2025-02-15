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

  Future<PaymentIntentModel?> createPaymentIntent(
      PaymentIntentInputModel paymentIntentInputModel) async {
    try {
      var response = await apiService.post(
        body: paymentIntentInputModel.toJson(),
        contentType: Headers.formUrlEncodedContentType,
        url: "https://api.stripe.com/v1/payment_intents",
        token: ApiKeys.secrretKey,
      );

      return PaymentIntentModel.fromJson(response.data);
    } catch (e) {
      print("Stripe API Error: $e");
      return null;
    }
  }

  Future<bool> initPaymentSheet(
      {required PaymentInitSheetInputModel paymentInitSheetInputModel}) async {
    try {
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          merchantDisplayName: 'Ahmed Hamada',
          paymentIntentClientSecret:
              paymentInitSheetInputModel.paymentIntentClientSecret,
          customerEphemeralKeySecret:
              paymentInitSheetInputModel.ephemeralKeySecret,
          customerId: paymentInitSheetInputModel.customerId,
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

  Future<bool> doPayment(
      {required PaymentIntentInputModel paymentIntentInputModel}) async {
    var paymentIntentModel = await createPaymentIntent(paymentIntentInputModel);
    var ephemeralKey = await createEphemeralKey(
        customerId: paymentIntentInputModel.customerId);
    if (paymentIntentModel == null || paymentIntentModel.clientSecret == null) {
      print("Failed to create PaymentIntent");
      return false;
    }
    var initPaymentSheetModel = PaymentInitSheetInputModel(
        paymentIntentClientSecret: paymentIntentModel.clientSecret!,
        ephemeralKeySecret: ephemeralKey!.secret!,
        customerId: paymentIntentInputModel.customerId);
    bool initSuccess = await initPaymentSheet(
        paymentInitSheetInputModel: initPaymentSheetModel);

    if (!initSuccess) return false;

    return await presentPaymentSheet();
  }

  Future<PaymentIntentModel?> createCustomer(
      PaymentIntentInputModel paymentIntentInputModel) async {
    try {
      var response = await apiService.post(
        body: paymentIntentInputModel.toJson(),
        contentType: Headers.formUrlEncodedContentType,
        url: "https://api.stripe.com/v1/payment_intents",
        token: ApiKeys.secrretKey,
      );

      return PaymentIntentModel.fromJson(response.data);
    } catch (e) {
      print("Stripe API Error: $e");
      return null;
    }
  }

  Future<EphemeralKeyModel?> createEphemeralKey(
      {required String customerId}) async {
    try {
      var response = await apiService.post(
          body: {
            "customer": customerId,
          },
          contentType: Headers.formUrlEncodedContentType,
          url: "https://api.stripe.com/v1/payment_intents",
          token: ApiKeys.secrretKey,
          headers: {
            "Authorization": "Bearer ${ApiKeys.secrretKey}",
            'Stripe-Version': '2025-01-27.acacia',
          });
      var ephemeralKey = EphemeralKeyModel.fromJson(response.data);
      return ephemeralKey;
    } catch (e) {
      print("Stripe API Error: $e");
      return null;
    }
  }
}
