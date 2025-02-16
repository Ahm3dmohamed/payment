import 'package:payment/features/checkout/data/models/amount_model/amount_model.dart';
import 'package:payment/features/checkout/data/models/amount_model/details.dart';
import 'package:payment/features/checkout/data/models/amount_model/items/items.dart';
import 'package:payment/features/checkout/data/models/amount_model/items/order_item_model.dart';

({AmountModel amountModel, Items itemsList}) getTransactionData() {
  var orderItems = <OrderItemModel>[
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
