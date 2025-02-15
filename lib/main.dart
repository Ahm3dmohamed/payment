import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:payment/core/utils/api_keys.dart';
import 'package:payment/features/checkout/presentation/views/my_cart_view.dart.dart';

void main() {
  Stripe.publishableKey = ApiKeys.publishableKey;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyCartView(),
    );
  }
}

//  paymentIntentObject Create payment intent (amount, currency)
// init payment sheet(paymentIntentClientSecret)
// present payment sheet()

// Future<void> initPaymentSheet() async {
//     try {
//       // 1. create payment intent on the server

//       // 2. initialize the payment sheet
//      await Stripe.instance.initPaymentSheet(
//         paymentSheetParameters: SetupPaymentSheetParameters(
//           // Main params
//           merchantDisplayName: 'Flutter Stripe Store Demo',
//           paymentIntentClientSecret: data['paymentIntent'],

//           style: ThemeMode.dark,
//         ),
//       );
//       setState(() {
//         _ready = true;
//       });
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error: $e')),
//       );
//       rethrow;
//     }
// }
