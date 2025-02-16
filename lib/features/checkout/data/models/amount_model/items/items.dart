import 'item.dart';
import 'shipping_address.dart';

class Items {
  List<Item>? items;
  ShippingAddress? shippingAddress;

  Items({this.items, this.shippingAddress});

  factory Items.fromJson(Map<String, dynamic> json) => Items(
        items: (json['items'] as List<dynamic>?)
            ?.map((e) => Item.fromJson(e as Map<String, dynamic>))
            .toList(),
        shippingAddress: json['shipping_address'] == null
            ? null
            : ShippingAddress.fromJson(
                json['shipping_address'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'items': items?.map((e) => e.toJson()).toList(),
        'shipping_address': shippingAddress?.toJson(),
      };
}
