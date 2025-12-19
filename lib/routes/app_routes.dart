import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservation_system/features/product/presentation/screens/product_list_screen.dart';
import 'package:reservation_system/features/product/presentation/screens/product_detail_screen.dart';
import 'package:reservation_system/features/product/presentation/screens/pre_order_screen.dart';
import 'package:reservation_system/features/product/presentation/screens/checkout_screen.dart';
import 'package:reservation_system/features/product/presentation/screens/order_confirmation_screen.dart';
import 'package:reservation_system/features/product/presentation/screens/order_history_screen.dart';
import 'package:reservation_system/features/product/presentation/screens/order_tracking_screen.dart';
import 'package:reservation_system/features/user/domain/entities/user.dart'; // Import User and UserRole
import 'package:reservation_system/features/product/presentation/providers/auth_provider.dart';

enum AppRoute {
  home('/'),
  productList('/products'),
  productDetail('/products/:id'),
  preOrder('/pre-order/:id'),
  checkout('/checkout'),
  orderConfirmation('/order-confirmation'),
  orderHistory('/my-orders'),
  orderTracking('/order-tracking/:orderId'),
  login('/login'),
  register('/register'),
  profile('/profile');

  final String path;
  const AppRoute(this.path);
}

class AppRouter {
  static GoRouter getRouter(WidgetRef ref) {
    return GoRouter(
      initialLocation: AppRoute.home.path,
      debugLogDiagnostics: true,
      redirect: (context, state) {
        final authState = ref.read(authProvider);
        final isLoggedIn = authState.user != null;
        
        // Get the UserRole enum value directly (no .name needed)
        final userRole = authState.user?.role;
        
        // Compare with your actual UserRole enum values
        final isAdmin = userRole == UserRole.admin;
        // Note: Your UserRole enum only has 'client' and 'admin'
        // No 'staff' or 'customer' in your current enum

        // Define protected routes
        final protectedRoutes = [
          AppRoute.preOrder.path,
          AppRoute.checkout.path,
          AppRoute.orderHistory.path,
          AppRoute.orderTracking.path,
          AppRoute.profile.path,
        ];

        // For GoRouter 15.1.2, use state.matchedLocation
        final currentPath = state.matchedLocation;

        // Check if trying to access protected route without login
        if (protectedRoutes.any((route) => currentPath.startsWith(route))) {
          if (!isLoggedIn) {
            return AppRoute.login.path;
          }
        }

        // Admin-only routes
        if (currentPath.contains('/admin') && !isAdmin) {
          return AppRoute.home.path;
        }

        // Note: Removed staff checks since UserRole doesn't have 'staff'
        // If you need staff routes later, update your UserRole enum

        // If logged in and trying to access login/register, redirect to home
        if (isLoggedIn &&
            (currentPath == AppRoute.login.path ||
                currentPath == AppRoute.register.path)) {
          return AppRoute.home.path;
        }

        return null;
      },
      routes: [
        GoRoute(
          path: AppRoute.home.path,
          name: AppRoute.home.name,
          builder: (context, state) => const ProductListScreen(),
        ),
        GoRoute(
          path: AppRoute.productList.path,
          name: AppRoute.productList.name,
          builder: (context, state) => const ProductListScreen(),
        ),
        GoRoute(
          path: AppRoute.productDetail.path,
          name: AppRoute.productDetail.name,
          builder: (context, state) {
            final productId = state.pathParameters['id']!;
            return ProductDetailScreen(productId: productId);
          },
        ),
        GoRoute(
          path: AppRoute.preOrder.path,
          name: AppRoute.preOrder.name,
          builder: (context, state) {
            final productId = state.pathParameters['id']!;
            return PreOrderScreen(productId: productId);
          },
        ),
        GoRoute(
          path: AppRoute.checkout.path,
          name: AppRoute.checkout.name,
          builder: (context, state) => const CheckoutScreen(),
        ),
        GoRoute(
          path: AppRoute.orderConfirmation.path,
          name: AppRoute.orderConfirmation.name,
          builder: (context, state) {
            final orderId = state.uri.queryParameters['orderId'];
            return OrderConfirmationScreen(orderId: orderId);
          },
        ),
        GoRoute(
          path: AppRoute.orderHistory.path,
          name: AppRoute.orderHistory.name,
          builder: (context, state) => const OrderHistoryScreen(),
        ),
        GoRoute(
          path: AppRoute.orderTracking.path,
          name: AppRoute.orderTracking.name,
          builder: (context, state) {
            final orderId = state.pathParameters['orderId']!;
            return OrderTrackingScreen(orderId: orderId);
          },
        ),
      ],
      errorBuilder: (context, state) {
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 64, color: Colors.red),
                const SizedBox(height: 16),
                Text(
                  '404 - Page Not Found',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Text(
                  'The page you are looking for doesn\'t exist.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => GoRouter.of(context).go(AppRoute.home.path),
                  child: const Text('Go to Home'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}