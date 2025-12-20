import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservation_system/features/order/domain/entities/order_item.dart'; // ✅ FIX
import 'package:reservation_system/features/order/presentation/notifiers/order_form_notifier.dart';
import 'package:reservation_system/features/order/presentation/state/order_form_state.dart';

final orderFormNotifierProvider =
    StateNotifierProvider<OrderFormNotifier, OrderFormState>((ref) {
  return OrderFormNotifier();
});

final orderFormItemsProvider = Provider<List<OrderItem>>((ref) {
  return ref.watch(
    orderFormNotifierProvider.select((state) => state.items),
  );
});

final orderFormTotalProvider = Provider<double>((ref) {
  return ref.watch(
    orderFormNotifierProvider.select((state) => state.totalAmount),
  );
});

final orderFormIsValidProvider = Provider<bool>((ref) {
  return ref.watch(
    orderFormNotifierProvider.select((state) => state.isValid),
  );
});

final orderFormIsLoadingProvider = Provider<bool>((ref) {
  return ref.watch(
    orderFormNotifierProvider.select((state) => state.isLoading),
  );
});
