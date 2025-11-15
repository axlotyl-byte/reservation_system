import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reservation_system/features/order/domain/entities/order_item.dart';
import '../../domain/entities/order.dart' as order_entity;
import 'order_item_model.dart';

class OrderModel extends order_entity.Order {
  const OrderModel({
    required String id,
    required String customerId,
    required List<OrderItem> items,
    required double totalAmount,
    required String status,
    required DateTime createdAt,
    DateTime? pickupDate,
  }) : super(
          id: id,
          customerId: customerId,
          items: items,
          totalAmount: totalAmount,
          status: status,
          createdAt: createdAt,
          pickupDate: pickupDate,
        );

  factory OrderModel.fromSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    final items =
        (data['items'] as List).map((e) => OrderItemModel.fromJson(e)).toList();

    return OrderModel(
      id: doc.id,
      customerId: data['customerId'],
      items: items, // ✅ compatible with List<OrderItem>
      totalAmount: (data['totalAmount'] ?? data['total'] ?? 0).toDouble(),
      status: data['status'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      pickupDate: data['pickupDate'] != null
          ? (data['pickupDate'] as Timestamp).toDate()
          : null,
    );
  }

   factory OrderModel.fromEntity(order_entity.Order order) {
    return OrderModel(
      id: order.id,
      customerId: order.customerId,
      items: order.items,
      totalAmount: order.totalAmount,
      status: order.status,
      createdAt: order.createdAt,
      pickupDate: order.pickupDate,
    );
  }

  Map<String, dynamic> toJson() => {
        'customerId': customerId,
        'items': items
            .map((e) => (e is OrderItemModel)
                ? e.toJson()
                : OrderItemModel(
                    productId: e.productId,
                    productName: e.productName,
                    quantity: e.quantity,
                    price: e.price,
                  ).toJson())
            .toList(),
        'totalAmount': totalAmount,
        'status': status,
        'createdAt': createdAt,
        if (pickupDate != null) 'pickupDate': pickupDate,
      };
}
