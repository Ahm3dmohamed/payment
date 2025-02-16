import 'package:payment/features/checkout/data/models/amount_model/items/order_item_model.dart';

import 'order_item_model.dart';

class Items {
  final List<OrderItemModel> items;

  Items({required this.items});

  factory Items.fromJson(Map<String, dynamic> json) => Items(
        items: (json['items'] as List<dynamic>?)
                ?.map((e) => OrderItemModel.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
      );

  Map<String, dynamic> toJson() => {
        'items': items.map((e) => e.toJson()).toList(),
      };
}
