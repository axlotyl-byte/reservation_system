// lib/features/order/presentation/providers/cart_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartItem {
  final String id;
  final String name;
  final String? description;
  final double price;
  final int quantity;
  final String? imageUrl;
  final Map<String, dynamic>? extras; // For customization like size, add-ons
  final String? category;
  final DateTime addedAt;

  CartItem({
    required this.id,
    required this.name,
    this.description,
    required this.price,
    this.quantity = 1,
    this.imageUrl,
    this.extras,
    this.category,
    DateTime? addedAt,
  }) : addedAt = addedAt ?? DateTime.now();

  CartItem copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    int? quantity,
    String? imageUrl,
    Map<String, dynamic>? extras,
    String? category,
    DateTime? addedAt,
  }) {
    return CartItem(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      imageUrl: imageUrl ?? this.imageUrl,
      extras: extras ?? this.extras,
      category: category ?? this.category,
      addedAt: addedAt ?? this.addedAt,
    );
  }

  double get totalPrice => price * quantity;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartItem &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          _areExtrasEqual(extras, other.extras);

  bool _areExtrasEqual(Map<String, dynamic>? a, Map<String, dynamic>? b) {
    if (a == null && b == null) return true;
    if (a == null || b == null) return false;
    if (a.length != b.length) return false;

    for (final key in a.keys) {
      if (a[key] != b[key]) return false;
    }
    return true;
  }

  @override
  int get hashCode => Object.hash(id, extras);
}

class CartState {
  final List<CartItem> items;
  final double subtotal;
  final double tax;
  final double serviceFee;
  final double total;
  final DateTime lastUpdated;

  CartState({
    List<CartItem>? items,
    this.tax = 0.08, // 8% tax rate - adjust as needed
    this.serviceFee = 0.0,
  })  : items = items ?? [],
        subtotal = _calculateSubtotal(items ?? []),
        total = _calculateTotal(items ?? [], tax, serviceFee),
        lastUpdated = DateTime.now();

  static double _calculateSubtotal(List<CartItem> items) {
    return items.fold(0, (sum, item) => sum + item.totalPrice);
  }

  static double _calculateTotal(
      List<CartItem> items, double tax, double serviceFee) {
    final subtotal = _calculateSubtotal(items);
    return subtotal + (subtotal * tax) + serviceFee;
  }

  CartState copyWith({
    List<CartItem>? items,
    double? tax,
    double? serviceFee,
  }) {
    return CartState(
      items: items ?? this.items,
      tax: tax ?? this.tax,
      serviceFee: serviceFee ?? this.serviceFee,
    );
  }

  bool get isEmpty => items.isEmpty;
  bool get isNotEmpty => items.isNotEmpty;
  int get itemCount => items.fold(0, (sum, item) => sum + item.quantity);
  int get uniqueItemCount => items.length;
}

class CartNotifier extends StateNotifier<CartState> {
  CartNotifier() : super(CartState());

  // Add item to cart
  void addItem(CartItem newItem) {
    // Check if item with same ID and extras already exists
    final existingIndex = state.items.indexWhere((item) => item == newItem);

    if (existingIndex >= 0) {
      // Update quantity of existing item
      final updatedItems = List<CartItem>.from(state.items);
      final existingItem = updatedItems[existingIndex];
      updatedItems[existingIndex] = existingItem.copyWith(
        quantity: existingItem.quantity + newItem.quantity,
      );
      state = state.copyWith(items: updatedItems);
    } else {
      // Add new item
      state = state.copyWith(items: [...state.items, newItem]);
    }
  }

  // Remove item from cart
  void removeItem(String itemId, {Map<String, dynamic>? extras}) {
    state = state.copyWith(
      items: state.items
          .where((item) =>
              !(item.id == itemId && _areExtrasEqual(item.extras, extras)))
          .toList(),
    );
  }

  // Update item quantity
  void updateQuantity(String itemId, int newQuantity,
      {Map<String, dynamic>? extras}) {
    if (newQuantity <= 0) {
      removeItem(itemId, extras: extras);
      return;
    }

    final updatedItems = state.items.map((item) {
      if (item.id == itemId && _areExtrasEqual(item.extras, extras)) {
        return item.copyWith(quantity: newQuantity);
      }
      return item;
    }).toList();

    state = state.copyWith(items: updatedItems);
  }

  // Increase item quantity by 1
  void incrementQuantity(String itemId, {Map<String, dynamic>? extras}) {
    final item = state.items.firstWhere(
      (item) => item.id == itemId && _areExtrasEqual(item.extras, extras),
      orElse: () => throw Exception('Item not found in cart'),
    );
    updateQuantity(itemId, item.quantity + 1, extras: extras);
  }

  // Decrease item quantity by 1
  void decrementQuantity(String itemId, {Map<String, dynamic>? extras}) {
    final item = state.items.firstWhere(
      (item) => item.id == itemId && _areExtrasEqual(item.extras, extras),
      orElse: () => throw Exception('Item not found in cart'),
    );
    updateQuantity(itemId, item.quantity - 1, extras: extras);
  }

  // Clear entire cart
  void clearCart() {
    state = CartState();
  }

  // Update tax rate
  void updateTaxRate(double newTaxRate) {
    state = state.copyWith(tax: newTaxRate);
  }

  // Update service fee
  void updateServiceFee(double newServiceFee) {
    state = state.copyWith(serviceFee: newServiceFee);
  }

  // Check if item is in cart
  bool containsItem(String itemId, {Map<String, dynamic>? extras}) {
    return state.items.any(
        (item) => item.id == itemId && _areExtrasEqual(item.extras, extras));
  }

  // Get item from cart
  CartItem? getItem(String itemId, {Map<String, dynamic>? extras}) {
    try {
      return state.items.firstWhere(
          (item) => item.id == itemId && _areExtrasEqual(item.extras, extras));
    } catch (_) {
      return null;
    }
  }

  // Helper method to compare extras
  bool _areExtrasEqual(Map<String, dynamic>? a, Map<String, dynamic>? b) {
    if (a == null && b == null) return true;
    if (a == null || b == null) return false;
    if (a.length != b.length) return false;

    for (final key in a.keys) {
      if (a[key] != b[key]) return false;
    }
    return true;
  }
}

// Main cart provider
final cartProvider = StateNotifierProvider<CartNotifier, CartState>((ref) {
  return CartNotifier();
});

// Derived providers for specific data
final cartItemsProvider = Provider<List<CartItem>>((ref) {
  return ref.watch(cartProvider).items;
});

final cartItemCountProvider = Provider<int>((ref) {
  return ref.watch(cartProvider).itemCount;
});

final cartUniqueItemCountProvider = Provider<int>((ref) {
  return ref.watch(cartProvider).uniqueItemCount;
});

final cartSubtotalProvider = Provider<double>((ref) {
  return ref.watch(cartProvider).subtotal;
});

final cartTaxAmountProvider = Provider<double>((ref) {
  return ref.watch(cartProvider).subtotal * ref.watch(cartProvider).tax;
});

final cartServiceFeeProvider = Provider<double>((ref) {
  return ref.watch(cartProvider).serviceFee;
});

final cartTotalProvider = Provider<double>((ref) {
  return ref.watch(cartProvider).total;
});

final cartIsEmptyProvider = Provider<bool>((ref) {
  return ref.watch(cartProvider).isEmpty;
});

// Provider for cart badge count (for navigation)
final cartBadgeCountProvider = Provider<int>((ref) {
  return ref.watch(cartItemCountProvider);
});
