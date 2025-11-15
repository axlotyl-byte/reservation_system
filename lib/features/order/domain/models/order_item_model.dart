// lib/features/order/domain/models/order_item_model.dart
import '../../domain/entities/order_item.dart' as entity;

class OrderItemModel extends entity.OrderItem {
  const OrderItemModel({
    required String productId,
    required String productName,
    required int quantity,
    required double price,
  }) : super(
          productId: productId,
          productName: productName,
          quantity: quantity,
          price: price,
        );

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      productId: json['productId'],
      productName: json['productName'],
      quantity: json['quantity'],
      price: (json['price'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        'productId': productId,
        'productName': productName, 
        'quantity': quantity,
        'price': price,
      };
}
