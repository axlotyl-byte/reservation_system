// lib/features/order/presentation/state/order_state.dart
import 'package:reservation_system/features/order/domain/entities/order.dart';

class OrderState {
  final List<Order> orders;
  final Order? selectedOrder;
  final bool isLoading;
  final String? error;
  final String? successMessage;

  const OrderState({
    this.orders = const [],
    this.selectedOrder,
    this.isLoading = false,
    this.error,
    this.successMessage,
  });

  OrderState copyWith({
    List<Order>? orders,
    Order? selectedOrder,
    bool? isLoading,
    String? error,
    String? successMessage,
  }) {
    return OrderState(
      orders: orders ?? this.orders,
      selectedOrder: selectedOrder ?? this.selectedOrder,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      successMessage: successMessage ?? this.successMessage,
    );
  }

  OrderState loading() {
    return copyWith(
      isLoading: true,
      error: null,
      successMessage: null,
    );
  }

  OrderState success(List<Order> orders) {
    return copyWith(
      orders: orders,
      isLoading: false,
      error: null,
      successMessage: null,
    );
  }

  OrderState successWithOrder(Order order) {
    return copyWith(
      selectedOrder: order,
      isLoading: false,
      error: null,
      successMessage: null,
    );
  }

  OrderState errorState(String errorMessage) {
    return copyWith(
      isLoading: false,
      error: errorMessage,
      successMessage: null,
    );
  }

  OrderState orderPlaced(Order order) {
    return copyWith(
      orders: [...orders, order],
      isLoading: false,
      error: null,
      successMessage: 'Order placed successfully',
    );
  }

  OrderState orderUpdated(Order order) {
    final updatedOrders =
        orders.map((o) => o.id == order.id ? order : o).toList();
    return copyWith(
      orders: updatedOrders,
      selectedOrder: selectedOrder?.id == order.id ? order : selectedOrder,
      isLoading: false,
      error: null,
      successMessage: 'Order updated successfully',
    );
  }

  OrderState orderDeleted(String orderId) {
    final filteredOrders = orders.where((o) => o.id != orderId).toList();
    final updatedSelectedOrder =
        selectedOrder?.id == orderId ? null : selectedOrder;

    return copyWith(
      orders: filteredOrders,
      selectedOrder: updatedSelectedOrder,
      isLoading: false,
      error: null,
      successMessage: 'Order deleted successfully',
    );
  }

  OrderState clearMessages() {
    return copyWith(
      error: null,
      successMessage: null,
    );
  }
}
