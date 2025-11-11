import 'package:equatable/equatable.dart';

class OrderItem extends Equatable {
  final String productId;
  final String productName;
  final int quantity;
  final double price;

  const OrderItem({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.price,
  });

  double get total => quantity * price;

  @override
  List<Object?> get props => [productId, productName, quantity, price];
}