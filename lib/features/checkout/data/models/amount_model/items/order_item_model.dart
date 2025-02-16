class OrderItemModel {
  final String name;
  final int quantity;
  final String price;
  final String currency;

  OrderItemModel({
    required this.name,
    required this.quantity,
    required this.price,
    required this.currency,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) => OrderItemModel(
        name: json['name'] ?? '',
        quantity: json['quantity'] ?? 0,
        price: json['price'] ?? '0.00',
        currency: json['currency'] ?? 'USD',
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'quantity': quantity,
        'price': price,
        'currency': currency,
      };
}
