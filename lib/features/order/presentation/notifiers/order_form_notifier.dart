// lib/features/order/presentation/notifiers/order_form_notifier.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservation_system/features/order/domain/entities/order_item.dart';
import 'package:reservation_system/features/order/presentation/state/order_form_state.dart';

class OrderFormNotifier extends StateNotifier<OrderFormState> {
  OrderFormNotifier() : super(const OrderFormState());

  void setCustomerId(String customerId) {
    state = state.copyWith(customerId: customerId);
  }

  void addOrderItem(OrderItem item) {
    state = state.addItem(item);
  }

  void removeOrderItem(int index) {
    state = state.removeItem(index);
  }

  void updateOrderItem(int index, OrderItem item) {
    state = state.updateItem(index, item);
  }

  void setStatus(String status) {
    state = state.copyWith(status: status);
  }

  void setPickupDate(DateTime? pickupDate) {
    state = state.copyWith(pickupDate: pickupDate);
  }

  void setLoading(bool isLoading) {
    state = state.copyWith(isLoading: isLoading);
  }

  void setError(String? error) {
    state = state.copyWith(error: error);
  }

  void reset() {
    state = state.reset();
  }
}
