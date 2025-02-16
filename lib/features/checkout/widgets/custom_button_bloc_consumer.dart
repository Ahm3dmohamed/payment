import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:payment/core/utils/api_keys.dart';
import 'package:payment/core/widgets/checkout_button.dart';
import 'package:payment/features/checkout/data/models/payment_intent_input_model.dart';
import 'package:payment/features/checkout/data/models/amount_model/amount_model.dart';
import 'package:payment/features/checkout/data/models/amount_model/details.dart';
import 'package:payment/features/checkout/data/models/amount_model/items/items.dart';
import 'package:payment/features/checkout/data/models/amount_model/items/order_item_model.dart';
import 'package:payment/features/checkout/presentation/manager/cubit/payment_cubit.dart';
import 'package:payment/features/checkout/presentation/views/thanks_you_view.dart';
import 'package:payment/features/checkout/widgets/payment_methods_listview.dart';

class CustomBottonBlocConsumer extends StatefulWidget {
  const CustomBottonBlocConsumer({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CustomBottonBlocConsumerState createState() =>
      _CustomBottonBlocConsumerState();
}

class _CustomBottonBlocConsumerState extends State<CustomBottonBlocConsumer> {
  int selectedPaymentMethod = 0; // 0 = Credit Card, 1 = PayPal

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PaymentMethods(
            onMethodSelected: (index) =>
                setState(() => selectedPaymentMethod = index)),
        const SizedBox(height: 10),
        BlocConsumer<PaymentCubit, PaymentCubitState>(
          listener: (context, state) {
            if (state is PaymentSuccess) {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const ThanksYouView()));
            } else if (state is PaymentFailure) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(state.errMessage),
                  backgroundColor: Colors.red));
            }
          },
          builder: (context, state) {
            return CheckoutButton(
              isLoading: state is PaymentLoading,
              text: "Pay Now",
              onPressed: () => selectedPaymentMethod == 0
                  ? executeCreditCardPayment(context)
                  : executePaypalPayment(context, getTransactionData()),
              total: 100,
            );
          },
        ),
      ],
    );
  }

  void executePaypalPayment(BuildContext context,
      ({AmountModel amountModel, Items itemsList}) transactionData) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => PaypalCheckoutView(
        sandboxMode: true,
        clientId: ApiKeys.paypalClientId,
        secretKey: ApiKeys.paypalSecret,
        transactions: [
          {
            "amount": {
              "total": transactionData.amountModel.total,
              "currency": transactionData.amountModel.currency,
              "details": transactionData.amountModel.details?.toJson(),
            },
            "description": "Payment transaction.",
            "item_list": {
              "items": transactionData.itemsList.items
                  .map((item) => item.toJson())
                  .toList()
            }
          }
        ],
        note: "Contact us for any questions.",
        onSuccess: (params) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (_) => const ThanksYouView()));
          context.read<PaymentCubit>().emit(PaymentSuccess());
        },
        onError: (error) {
          print("onError: $error");
          Navigator.pop(context);
        },
        onCancel: () => print('Payment cancelled'),
      ),
    ));
  }

  void executeCreditCardPayment(BuildContext context) {
    var paymentIntentInputModel = PaymentIntentInputModel(
      customerId: "cus_RmOzspT2Pefanh",
      amount: "100",
      currency: "USD",
    );
    context.read<PaymentCubit>().doPayment(paymentIntentInputModel);
  }

  ({AmountModel amountModel, Items itemsList}) getTransactionData() {
    List<OrderItemModel> orderItems = [
      OrderItemModel(name: "Apple", quantity: 4, price: '5', currency: "USD"),
      OrderItemModel(
          name: "Pineapple", quantity: 5, price: '10', currency: "USD"),
    ];

    double subtotal = orderItems.fold(
        0, (sum, item) => sum + (int.parse(item.price) * item.quantity));

    return (
      amountModel: AmountModel(
        total: subtotal.toStringAsFixed(2),
        currency: "USD",
        details: Details(
            subtotal: subtotal.toStringAsFixed(2),
            shipping: "0",
            shippingDiscount: 0),
      ),
      itemsList: Items(items: orderItems)
    );
  }
}
