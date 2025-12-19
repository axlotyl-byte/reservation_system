// lib/features/cart/presentation/screens/cart_screen.dart
import 'package:flutter/material.dart';
import 'package:reservation_system/theme/theme.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.shopping_cart,
              size: 80,
              color: Colors.grey,
            ),
            const SizedBox(height: 20),
            Text(
              'Your cart is empty',
              style: BakeryTextStyles.titleMedium(context),
            ),
            const SizedBox(height: 10),
            Text(
              'Add some delicious treats to your cart!',
              style: BakeryTextStyles.bodyMedium(context).copyWith(
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to home
              },
              child: const Text('Browse Products'),
            ),
          ],
        ),
      ),
    );
  }
}