import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reservation_system/features/product/presentation/screens/main_screen.dart';
import 'package:reservation_system/features/product/presentation/screens/product_detail_screen.dart';
import 'package:reservation_system/features/product/presentation/screens/order_confirmation_screen.dart';
import 'package:reservation_system/features/product/presentation/screens/order_history_screen.dart';
import 'package:reservation_system/features/product/presentation/screens/order_tracking_screen.dart';
import 'package:reservation_system/features/product/presentation/screens/checkout_screen.dart';

enum AppRoute {
  home('/'),
  productDetail('/product/:id'),
  orderConfirmation('/order-confirmation'),
  orderHistory('/my-orders'),
  orderTracking('/order-tracking/:orderId'),
  checkout('/checkout');

  final String path;
  const AppRoute(this.path);
}

class AppRouter {
  static GoRouter getRouter() {
    return GoRouter(
      initialLocation: AppRoute.home.path,
      debugLogDiagnostics: true,
      routes: [
        // Home
        GoRoute(
          path: AppRoute.home.path,
          name: AppRoute.home.name,
          builder: (context, state) => const MainScreen(),
          routes: [
            // Product Detail
            GoRoute(
              path: 'product/:id',
              name: AppRoute.productDetail.name,
              builder: (context, state) {
                final productId = state.pathParameters['id']!;
                return ProductDetailScreen(productId: productId);
              },
            ),
          ],
        ),

        // Order Confirmation (uses query parameter orderId)
        GoRoute(
          path: AppRoute.orderConfirmation.path,
          name: AppRoute.orderConfirmation.name,
          builder: (context, state) {
            final orderId = state.uri.queryParameters['orderId'];
            return OrderConfirmationScreen(orderId: orderId);
          },
        ),

        // Order Tracking (path parameter)
        GoRoute(
          path: AppRoute.orderTracking.path,
          name: AppRoute.orderTracking.name,
          builder: (context, state) {
            final orderId = state.pathParameters['orderId']!;
            return OrderTrackingScreen(orderId: orderId);
          },
        ),

        // Order History
        GoRoute(
          path: AppRoute.orderHistory.path,
          name: AppRoute.orderHistory.name,
          builder: (context, state) => const OrderHistoryScreen(),
        ),

        // Checkout
        GoRoute(
          path: AppRoute.checkout.path,
          name: AppRoute.checkout.name,
          builder: (context, state) => const CheckoutScreen(),
        ),
      ],
      errorBuilder: (context, state) => _buildErrorScreen(context),
    );
  }

  static Widget _buildErrorScreen(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.go(AppRoute.home.path),
          child: const Text('Go Home'),
        ),
      ),
    );
  }
}
