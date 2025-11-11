import 'package:equatable/equatable.dart';
import 'order_item.dart';

class Order extends Equatable {
  final String id;
  final String customerId;
  final List<OrderItem> items;
  final double totalAmount;
  final String status; // e.g. Pending, Confirmed, Completed, Cancelled
  final DateTime createdAt;
  final DateTime? pickupDate;

  const Order({
    required this.id,
    required this.customerId,
    required this.items,
    required this.totalAmount,
    required this.status,
    required this.createdAt,
    this.pickupDate,
  });

  @override
  List<Object?> get props =>
      [id, customerId, items, totalAmount, status, createdAt, pickupDate];
}
