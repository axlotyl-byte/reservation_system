import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservation_system/features/order/domain/entities/order.dart';
import 'package:reservation_system/features/order/presentation/notifiers/order_notifier.dart';
import 'package:reservation_system/features/order/presentation/state/order_state.dart';

/// -------------------------------
/// MAIN NOTIFIER PROVIDER
/// -------------------------------
final orderNotifierProvider =
    StateNotifierProvider<OrderNotifier, OrderState>((ref) {
  throw UnimplementedError(
    'orderNotifierProvider must be overridden in ProviderScope',
  );
});

/// -------------------------------
/// BASE STATE PROVIDERS
/// -------------------------------
final ordersProvider = Provider<List<Order>>((ref) {
  return ref.watch(
    orderNotifierProvider.select((state) => state.orders),
  );
});

final selectedOrderProvider = Provider<Order?>((ref) {
  return ref.watch(
    orderNotifierProvider.select((state) => state.selectedOrder),
  );
});

final ordersLoadingProvider = Provider<bool>((ref) {
  return ref.watch(
    orderNotifierProvider.select((state) => state.isLoading),
  );
});

final ordersErrorProvider = Provider<String?>((ref) {
  return ref.watch(
    orderNotifierProvider.select((state) => state.error),
  );
});

final ordersSuccessMessageProvider = Provider<String?>((ref) {
  return ref.watch(
    orderNotifierProvider.select((state) => state.successMessage),
  );
});

/// -------------------------------
/// SAFE DERIVED PROVIDERS
/// -------------------------------

/// Returns selected order as a list (SAFE, no null issues)
final selectedOrderAsListProvider = Provider<List<Order>>((ref) {
  final order = ref.watch(selectedOrderProvider);
  return order == null ? [] : [order];
});

/// -------------------------------
/// STATUS-BASED FILTER PROVIDERS
/// -------------------------------
final pendingOrdersProvider = Provider<List<Order>>((ref) {
  final orders = ref.watch(ordersProvider);
  return orders
      .where((order) => order.status.toLowerCase() == 'pending')
      .toList();
});

final completedOrdersProvider = Provider<List<Order>>((ref) {
  final orders = ref.watch(ordersProvider);
  return orders
      .where((order) => order.status.toLowerCase() == 'completed')
      .toList();
});

final cancelledOrdersProvider = Provider<List<Order>>((ref) {
  final orders = ref.watch(ordersProvider);
  return orders
      .where((order) => order.status.toLowerCase() == 'cancelled')
      .toList();
});

/// -------------------------------
/// CUSTOMER-SPECIFIC PROVIDER
/// -------------------------------
final customerOrdersProvider =
    Provider.family<List<Order>, String>((ref, customerId) {
  final orders = ref.watch(ordersProvider);
  return orders.where((order) => order.customerId == customerId).toList();
});
