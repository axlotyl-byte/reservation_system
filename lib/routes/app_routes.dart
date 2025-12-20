import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:reservation_system/features/product/presentation/screens/main_screen.dart';
import 'package:reservation_system/features/product/presentation/screens/product_detail_screen.dart';

/// ====================
/// ROUTE ENUM (ABSOLUTE)
/// ====================
enum AppRoute {
  home('/'),
  productDetail('/product/:id'),

  // Order routes will be added later when screens are created
  // preOrder('/pre-order/:productId'),
  // cart('/cart'),
  // checkout('/checkout'),
  // orderConfirmation('/order-confirmation/:orderId'),
  // orderHistory('/my-orders'),
  // orderDetail('/order/:id'),
  // orderTracking('/track-order/:orderId'),
  // adminDashboard('/admin'),
  // adminOrders('/admin/orders'),
  // adminOrderDetail('/admin/orders/:id'),
  // adminInventory('/admin/inventory'),
  // adminCalendar('/admin/calendar'),
  ;

  final String path;
  const AppRoute(this.path);
}

/// ====================
/// TRANSITION
/// ====================
CustomTransitionPage _fadePage<T>({
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (_, animation, __, child) {
      return FadeTransition(
        opacity: CurvedAnimation(
          parent: animation,
          curve: Curves.easeInOut,
        ),
        child: child,
      );
    },
  );
}

/// ====================
/// ROUTER
/// ====================
class AppRouter {
  static GoRouter getRouter() {
    return GoRouter(
      initialLocation: AppRoute.home.path,
      debugLogDiagnostics: true,
      routes: [
        /// ===== HOME =====
        GoRoute(
          path: AppRoute.home.path,
          name: AppRoute.home.name,
          pageBuilder: (context, state) =>
              _fadePage(state: state, child: const MainScreen()),
          routes: [
            GoRoute(
              path: 'product/:id',
              name: AppRoute.productDetail.name,
              pageBuilder: (context, state) => _fadePage(
                state: state,
                child: ProductDetailScreen(
                  productId: state.pathParameters['id']!,
                ),
              ),
            ),

            // Order routes will be added here later when screens are created
            // GoRoute(
            //   path: 'pre-order/:productId',
            //   name: AppRoute.preOrder.name,
            //   pageBuilder: (context, state) => _fadePage(
            //     state: state,
            //     child: PreOrderScreen(
            //       productId: state.pathParameters['productId']!,
            //     ),
            //   ),
            // ),
            // GoRoute(
            //   path: 'cart',
            //   name: AppRoute.cart.name,
            //   pageBuilder: (context, state) =>
            //       _fadePage(state: state, child: const CartScreen()),
            // ),
            // ... other order routes
          ],
        ),

        /// ===== ADMIN ROUTES =====
        // Will be added later when admin screens are created
        // GoRoute(
        //   path: AppRoute.adminDashboard.path,
        //   name: AppRoute.adminDashboard.name,
        //   pageBuilder: (context, state) =>
        //       _fadePage(state: state, child: const AdminDashboardScreen()),
        //   routes: [
        //     GoRoute(
        //       path: 'orders',
        //       name: AppRoute.adminOrders.name,
        //       pageBuilder: (context, state) =>
        //           _fadePage(state: state, child: const AdminOrdersScreen()),
        //     ),
        //     ... other admin routes
        //   ],
        // ),
      ],
      errorBuilder: (context, state) => _errorScreen(context, state),
    );
  }

  static Widget _errorScreen(BuildContext context, GoRouterState state) {
    return Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            const Text('Page not found'),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => context.go(AppRoute.home.path),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    );
  }
}

/// ====================
/// NAVIGATION HELPERS
/// ====================
extension AppRouteNavigation on BuildContext {
  void goToRoute(AppRoute route, {Map<String, String>? params}) {
    var path = route.path;
    params?.forEach((k, v) => path = path.replaceFirst(':$k', v));
    go(path);
  }
}
