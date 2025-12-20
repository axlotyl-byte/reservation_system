// lib/features/order/presentation/state/order_form_state.dart
import 'package:reservation_system/features/order/domain/entities/order_item.dart';

class OrderFormState {
  final String? customerId;
  final List<OrderItem> items;
  final double totalAmount;
  final String status;
  final DateTime? pickupDate;
  final bool isLoading;
  final String? error;

  const OrderFormState({
    this.customerId,
    this.items = const [],
    this.totalAmount = 0.0,
    this.status = 'pending',
    this.pickupDate,
    this.isLoading = false,
    this.error,
  });

  OrderFormState copyWith({
    String? customerId,
    List<OrderItem>? items,
    double? totalAmount,
    String? status,
    DateTime? pickupDate,
    bool? isLoading,
    String? error,
  }) {
    return OrderFormState(
      customerId: customerId ?? this.customerId,
      items: items ?? this.items,
      totalAmount: totalAmount ?? this.totalAmount,
      status: status ?? this.status,
      pickupDate: pickupDate ?? this.pickupDate,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  OrderFormState addItem(OrderItem item) {
    final newItems = [...items, item];
    final newTotal = newItems.fold(0.0, (sum, item) => sum + item.total);

    return copyWith(
      items: newItems,
      totalAmount: newTotal,
    );
  }

  OrderFormState removeItem(int index) {
    if (index < 0 || index >= items.length) return this;

    final newItems = List<OrderItem>.from(items);
    newItems.removeAt(index);
    final newTotal = newItems.fold(0.0, (sum, item) => sum + item.total);

    return copyWith(
      items: newItems,
      totalAmount: newTotal,
    );
  }

  OrderFormState updateItem(int index, OrderItem item) {
    if (index < 0 || index >= items.length) return this;

    final newItems = List<OrderItem>.from(items);
    newItems[index] = item;
    final newTotal = newItems.fold(0.0, (sum, item) => sum + item.total);

    return copyWith(
      items: newItems,
      totalAmount: newTotal,
    );
  }

  OrderFormState loading() {
    return copyWith(isLoading: true, error: null);
  }

  OrderFormState errorState(String errorMessage) {
    return copyWith(isLoading: false, error: errorMessage);
  }

  OrderFormState reset() {
    return const OrderFormState();
  }

  bool get isValid =>
      customerId != null && customerId!.isNotEmpty && items.isNotEmpty;
}
