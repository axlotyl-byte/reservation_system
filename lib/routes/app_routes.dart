// lib/core/routing/app_routes.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ==================== CORE SCREENS ====================
import 'package:reservation_system/features/order/presentation/screens/splash_screen.dart';
import 'package:reservation_system/features/order/presentation/screens/home_screen.dart';
import 'package:reservation_system/features/order/presentation/screens/main_layout.dart';
import 'package:reservation_system/features/core/presentation/screens/error_screen.dart';

// ==================== AUTH SCREENS ====================

// ==================== PRODUCT SCREENS ====================
import 'package:reservation_system/features/product/presentation/screens/product_list_screen.dart';
import 'package:reservation_system/features/product/presentation/screens/product_detail_screen.dart';

// ==================== ORDER SCREENS ====================
import 'package:reservation_system/features/order/presentation/screens/my_orders_screen.dart';
import 'package:reservation_system/features/order/presentation/screens/order_detail_screen.dart';

// ==================== CART SCREENS ====================
import 'package:reservation_system/features/order/presentation/screens/cart_screen.dart';

// ==================== USER ENTITIES ====================
import 'package:reservation_system/features/user/domain/entities/user.dart';

// ==================== ROUTE CONFIG ====================
import 'package:reservation_system/routes/route_config.dart';

// ==================== AUTH STREAM FOR ROUTER REFRESH ====================
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
          (dynamic _) => notifyListeners(),
        );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

// ==================== ROUTE GUARD ====================
class RouteGuard {
  static bool hasAccess({
    required UserRole userRole,
    required List<UserRole>? allowedRoles,
  }) {
    if (allowedRoles == null) return true;
    return allowedRoles.contains(userRole);
  }

  static bool canAccessCustomerFeatures(UserRole role) {
    return role == UserRole.client;
  }

  static bool canAccessAdminFeatures(UserRole role) {
    return role == UserRole.admin;
  }
}

// ==================== APP ROUTER ====================
class AppRouter {
  static GoRouter get router => _router;

  static final _router = GoRouter(
    initialLocation: RouteConfig.splash,
    errorBuilder: (context, state) => const ErrorScreen(),
    routes: [
      // ==================== SPLASH ====================
      GoRoute(
        path: RouteConfig.splash,
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),

      // ==================== AUTH ROUTES ====================
      
      // ==================== MAIN SHELL WITH LAYOUT ====================
      ShellRoute(
        builder: (context, state, child) {
          return MainLayout(
            currentRoute: state.matchedLocation,
            child: child,
          );
        },
        routes: [
          // ==================== HOME ====================
          GoRoute(
            path: RouteConfig.home,
            name: 'home',
            builder: (context, state) => const HomeScreen(),
          ),

          // ==================== PRODUCT ROUTES ====================
          GoRoute(
            path: RouteConfig.products,
            name: 'products',
            builder: (context, state) => const ProductListScreen(),
          ),
          GoRoute(
            path: RouteConfig.productDetail,
            name: 'productDetail',
            builder: (context, state) {
              final productId = state.pathParameters['id'] ?? '';
              return ProductDetailScreen(productId: productId);
            },
          ),

          // ==================== CART ====================
          GoRoute(
            path: RouteConfig.cart,
            name: 'cart',
            builder: (context, state) => const CartScreen(),
          ),

          // ==================== ORDER ROUTES ====================
          GoRoute(
            path: RouteConfig.orders,
            name: 'orders',
            builder: (context, state) => const MyOrdersScreen(),
          ),
          GoRoute(
            path: RouteConfig.orderDetail,
            name: 'orderDetail',
            builder: (context, state) {
              final orderId = state.pathParameters['id'] ?? '';
              return OrderDetailScreen(orderId: orderId);
            },
          ),
        ],
      ),
    ],
  );

  // ==================== AUTH GUARD ====================
}
