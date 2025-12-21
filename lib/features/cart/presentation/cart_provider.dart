import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/models/cart_item.dart';
import '../../cart/domain/models/cart.dart';

class CartNotifier extends StateNotifier<Cart> {
  CartNotifier() : super(Cart());

  void addToCart(CartItem item) {
    final index = state.items.indexWhere((i) => i.productId == item.productId);
    if (index >= 0) {
      final updated = List<CartItem>.from(state.items);
      updated[index] = CartItem(
        productId: item.productId,
        productName: item.productName,
        variant: item.variant,
        quantity: updated[index].quantity + item.quantity,
        price: item.price,
      );
      state = Cart(items: updated);
    } else {
      state = Cart(items: [...state.items, item]);
    }
  }

  void removeFromCart(String productId) {
    state = Cart(
        items: state.items.where((i) => i.productId != productId).toList());
  }

  void updateQuantity(String productId, int quantity) {
    final index = state.items.indexWhere((i) => i.productId == productId);
    if (index >= 0) {
      final updated = List<CartItem>.from(state.items);
      if (quantity <= 0) {
        updated.removeAt(index);
      } else {
        final item = updated[index];
        updated[index] = CartItem(
          productId: item.productId,
          productName: item.productName,
          variant: item.variant,
          quantity: quantity,
          price: item.price,
        );
      }
      state = Cart(items: updated);
    }
  }

  void clearCart() {
    state = Cart(items: []);
  }
}

final cartProvider =
    StateNotifierProvider<CartNotifier, Cart>((ref) => CartNotifier());
