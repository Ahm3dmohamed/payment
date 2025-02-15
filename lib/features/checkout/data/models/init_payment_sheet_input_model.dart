class PaymentInitSheetInputModel {
  final String paymentIntentClientSecret;
  final String ephemeralKeySecret;
  final String customerId;

  PaymentInitSheetInputModel(
      {required this.paymentIntentClientSecret,
      required this.ephemeralKeySecret,
      required this.customerId});
}
