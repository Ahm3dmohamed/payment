import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:payment/core/widgets/checkout_button.dart';
import 'package:payment/features/checkout/data/models/amount_model/amount_model.dart';
import 'package:payment/features/checkout/data/models/amount_model/details.dart';
import 'package:payment/features/checkout/data/models/amount_model/items/item.dart';
import 'package:payment/features/checkout/data/models/amount_model/items/items.dart';
import 'package:payment/features/checkout/data/models/payment_intent_input_model.dart';
import 'package:payment/features/checkout/presentation/manager/cubit/payment_cubit.dart';
import 'package:payment/features/checkout/presentation/views/thanks_you_view.dart';

class CustomBottonBlocConsumer extends StatelessWidget {
  const CustomBottonBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentCubit, PaymentCubitState>(
      listener: (context, state) {
        if (state is PaymentSuccess) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const ThanksYouView(),
            ),
          );
        } else if (state is PaymentFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errMessage),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        return CheckoutButton(
          isLoading: state is PaymentLoading,
          text: "Continue",
          onPressed: () {
            // PaymentIntentInputModel paymentIntentInputModel =
            //     PaymentIntentInputModel(
            //   customerId: "cus_RmOzspT2Pefanh",
            //   amount: "100",
            //   currency: "USD",
            // );

            // BlocProvider.of<PaymentCubit>(context)
            //     .doPayment(paymentIntentInputModel);

            // List orderItems = [
            //   {"name": "Apple", "quantity": 4, "price": '5', "currency": "USD"},
            //   {
            //     "name": "Pineapple",
            //     "quantity": 5,
            //     "price": '10',
            //     "currency": "USD"
            //   }
            // ];

            var transictionData = getTransictionData();
            Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => PaypalCheckoutView(
                sandboxMode: true,
                clientId: "",
                secretKey: "",
                transactions: [
                  {
                    "amount": {
                      "total": transictionData.amountModel,
                      "currency": transictionData.amountModel.currency,
                      "details": transictionData.amountModel.details!.toJson(),
                    },
                    "description": "The payment transaction description.",
                    // "payment_options": {
                    //   "allowed_payment_method":
                    //       "INSTANT_FUNDING_SOURCE"
                    // },
                    "item_list": {
                      "items": transictionData.itemsList.toJson(),
                    }
                  }
                ],
                note: "Contact us for any questions on your order.",
                onSuccess: (Map params) async {
                  print("onSuccess: $params");
                },
                onError: (error) {
                  print("onError: $error");
                  Navigator.pop(context);
                },
                onCancel: () {
                  print('cancelled:');
                },
              ),
            ));
          },
          total: 100,
        );
      },
    );
  }

  ({AmountModel amountModel, Items itemsList}) getTransictionData() {
    var amountModel = AmountModel(
      total: "100",
      currency: "USD",
      details: Details(
        subtotal: "100",
        shipping: "0",
        shippingDiscount: 0,
      ),
    );
    List<OrderItemModel> orderItems = [
      OrderItemModel(
        name: "Apple",
        quantity: 4,
        price: '5',
        currency: "USD",
      ),
      OrderItemModel(
        name: "Pineapple",
        quantity: 5,
        price: '10',
        currency: "USD",
      ),
    ];
    var itemsList = Items(
      items: orderItems,
    );
    return (itemsList: itemsList, amountModel: amountModel);
  }
}
