import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:reservation_system/features/cart/presentation/cart_provider.dart';
import 'package:reservation_system/features/cart/domain/models/cart_item.dart';
import 'package:reservation_system/theme/theme.dart';
import 'package:reservation_system/theme/widgets.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);
    final cartNotifier = ref.read(cartProvider.notifier);

    if (cart.items.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Cart')),
        body: context.emptyState(
          icon: Icons.shopping_cart_outlined,
          title: 'Your cart is empty',
          description: 'Add delicious bakery items to get started!',
          action: ElevatedButton(
            onPressed: () => context.go('/'),
            child: const Text('Browse Products'),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () => _showClearCartDialog(context, cartNotifier),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: cart.items.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (_, index) {
                final item = cart.items[index];
                return _buildCartItem(item, cartNotifier, context);
              },
            ),
          ),
          // Checkout Section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.grey.shade300)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total', style: TextStyle(fontSize: 16)),
                    context.priceDisplay(
                      price: cart.totalAmount,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: BakeryTheme.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => context.go('/checkout'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: BakeryTheme.primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('Proceed to Checkout'),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () => context.go('/'),
                    child: const Text('Continue Shopping'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItem(
      CartItem item, CartNotifier cartNotifier, BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Product Image
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.cake, color: Colors.grey),
            ),
            const SizedBox(width: 12),
            // Product Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.productName,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  if (item.variant != null)
                    Text(
                      item.variant!,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      context.quantitySelector(
                        quantity: item.quantity,
                        onDecrease: () => cartNotifier.updateQuantity(
                            item.productId, item.quantity - 1),
                        onIncrease: () => cartNotifier.updateQuantity(
                            item.productId, item.quantity + 1),
                      ),
                      context.priceDisplay(
                        price: item.price * item.quantity,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Remove Button
            IconButton(
              icon: const Icon(Icons.close, size: 20),
              onPressed: () => cartNotifier.removeFromCart(item.productId),
            ),
          ],
        ),
      ),
    );
  }

  void _showClearCartDialog(BuildContext context, CartNotifier cartNotifier) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Clear Cart'),
        content: const Text(
            'Are you sure you want to remove all items from your cart?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              cartNotifier.clearCart();
              Navigator.pop(context);
            },
            child: const Text('Clear', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
