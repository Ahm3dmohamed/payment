import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:payment/core/utils/api_keys.dart';
import 'package:payment/features/checkout/data/models/amount_model/amount_model.dart';
import 'package:payment/features/checkout/data/models/amount_model/items/items.dart';
import 'package:payment/features/checkout/presentation/manager/cubit/payment_cubit.dart';
import 'package:payment/features/checkout/presentation/views/thanks_you_view.dart';

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
        print("onSuccess: $params");

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
