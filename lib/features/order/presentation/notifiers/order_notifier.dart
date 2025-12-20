import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservation_system/features/order/domain/entities/order.dart';
import 'package:reservation_system/features/order/domain/usecases/delete_order.dart';
import 'package:reservation_system/features/order/domain/usecases/get_all_orders.dart';
import 'package:reservation_system/features/order/domain/usecases/get_customer_orders.dart';
import 'package:reservation_system/features/order/domain/usecases/get_order_by_id.dart';
import 'package:reservation_system/features/order/domain/usecases/place_order.dart';
import 'package:reservation_system/features/order/domain/usecases/update_order_status.dart'; // ensure this exists
import 'package:reservation_system/features/order/presentation/state/order_state.dart';

class OrderNotifier extends StateNotifier<OrderState> {
  final GetAllOrders getAllOrders;
  final GetOrderById getOrderById;
  final GetCustomerOrders getCustomerOrders;
  final PlaceOrder placeOrder;
  final UpdateOrder updateOrderStatusUseCase; // rename to avoid conflict
  final DeleteOrder deleteOrder;

  OrderNotifier({
    required this.getAllOrders,
    required this.getOrderById,
    required this.getCustomerOrders,
    required this.placeOrder,
    required this.updateOrderStatusUseCase, // renamed
    required this.deleteOrder,
  }) : super(const OrderState());

  Future<void> loadAllOrders() async {
    state = state.loading();

    final result = await getAllOrders();
    result.fold(
      (failure) => state = state.errorState(failure.toString()),
      (orders) => state = state.success(orders),
    );
  }

  Future<void> loadOrderById(String id) async {
    state = state.loading();

    final result = await getOrderById(id);
    result.fold(
      (failure) => state = state.errorState(failure.toString()),
      (order) => state = state.successWithOrder(order),
    );
  }

  Future<void> loadCustomerOrders(String customerId) async {
    state = state.loading();

    final result = await getCustomerOrders(customerId);
    result.fold(
      (failure) => state = state.errorState(failure.toString()),
      (orders) => state = state.success(orders),
    );
  }

  Future<void> createOrder(Order order) async {
    state = state.loading();

    final result = await placeOrder(order);
    result.fold(
      (failure) => state = state.errorState(failure.toString()),
      (createdOrder) => state = state.orderPlaced(createdOrder),
    );
  }

  Future<void> modifyOrder(Order order) async {
    state = state.loading();

    final result = await updateOrderStatusUseCase(order); // use renamed field
    result.fold(
      (failure) => state = state.errorState(failure.toString()),
      (updatedOrder) => state = state.orderUpdated(updatedOrder),
    );
  }

  Future<void> updateOrderStatus(String orderId, String newStatus) async {
    final currentOrder = state.orders.firstWhere(
      (order) => order.id == orderId,
      orElse: () => state.selectedOrder!,
    );

    final updatedOrder = Order(
      id: currentOrder.id,
      customerId: currentOrder.customerId,
      items: currentOrder.items,
      totalAmount: currentOrder.totalAmount,
      status: newStatus,
      createdAt: currentOrder.createdAt,
      pickupDate: currentOrder.pickupDate,
    );

    await modifyOrder(updatedOrder);
  }

  Future<void> removeOrder(String orderId) async {
    state = state.loading();

    final result = await deleteOrder(orderId);
    result.fold(
      (failure) => state = state.errorState(failure.toString()),
      (_) => state = state.orderDeleted(orderId),
    );
  }

  void selectOrder(Order order) {
    state = state.copyWith(selectedOrder: order);
  }

  void clearSelectedOrder() {
    state = state.copyWith(selectedOrder: null);
  }

  void clearMessages() {
    state = state.clearMessages();
  }

  void clearError() {
    if (state.error != null) {
      state = state.copyWith(error: null);
    }
  }

  void clearSuccessMessage() {
    if (state.successMessage != null) {
      state = state.copyWith(successMessage: null);
    }
  }
}
