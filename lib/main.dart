import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:reservation_system/routes/app_routes.dart';

// Screens
import 'package:reservation_system/features/product/presentation/screens/main_screen.dart';
import 'package:reservation_system/features/product/presentation/screens/product_detail_screen.dart';
import 'package:reservation_system/features/product/presentation/screens/pre_order_screen.dart';
import 'package:reservation_system/features/product/presentation/screens/checkout_screen.dart';
import 'package:reservation_system/features/product/presentation/screens/order_confirmation_screen.dart';
import 'package:reservation_system/features/product/presentation/screens/order_tracking_screen.dart';
import 'package:reservation_system/features/product/presentation/screens/order_history_screen.dart';
import 'package:reservation_system/features/product/presentation/screens/profile_screen.dart';
import 'package:reservation_system/features/product/presentation/screens/cart_screen.dart';

// Theme
import 'package:reservation_system/theme/theme.dart';

// Firebase Options
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GoRouter router = GoRouter(
      initialLocation: AppRoute.home.path,
      debugLogDiagnostics: true,
      routes: [
        // Main screen
        GoRoute(
          path: AppRoute.home.path,
          name: AppRoute.home.name,
          builder: (context, state) => const MainScreen(),
          routes: [
            // Product Detail
            GoRoute(
              path: 'product/:id',
              name: 'productDetail',
              builder: (context, state) {
                final productId = state.pathParameters['id']!;
                return ProductDetailScreen(productId: productId);
              },
            ),

            // Pre-order
            GoRoute(
              path: 'pre-order/:id',
              name: 'preOrder',
              builder: (context, state) {
                final productId = state.pathParameters['id']!;
                return PreOrderScreen(productId: productId);
              },
            ),

            // Checkout
            GoRoute(
              path: 'checkout',
              name: 'checkout',
              builder: (context, state) => const CheckoutScreen(),
            ),

            // Order Confirmation (use query parameter)
            GoRoute(
              path: 'order-confirmation',
              name: 'orderConfirmation',
              builder: (context, state) {
                final orderId = state.uri.queryParameters['orderId'];
                return OrderConfirmationScreen(orderId: orderId);
              },
            ),

            // Order Tracking
            GoRoute(
              path: 'order-tracking/:orderId',
              name: 'orderTracking',
              builder: (context, state) {
                final orderId = state.pathParameters['orderId']!;
                return OrderTrackingScreen(orderId: orderId);
              },
            ),

            // Order History
            GoRoute(
              path: 'my-orders',
              name: 'orderHistory',
              builder: (context, state) => const OrderHistoryScreen(),
            ),

            // Profile
            GoRoute(
              path: 'profile',
              name: 'profile',
              builder: (context, state) => const ProfileScreen(),
            ),

            // Cart
            GoRoute(
              path: 'cart',
              name: 'cart',
              builder: (context, state) => const CartScreen(),
            ),
          ],
        ),
      ],
      errorBuilder: (context, state) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                'Page Not Found',
                style: BakeryTextStyles.headlineMedium(context),
              ),
              const SizedBox(height: 8),
              Text(
                'The page you are looking for doesn\'t exist.',
                style: BakeryTextStyles.bodyMedium(context),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => context.go(AppRoute.home.path),
                child: const Text('Go to Home'),
              ),
            ],
          ),
        ),
      ),
    );

    return MaterialApp.router(
      title: 'Sweet Delights Bakery',
      theme: _buildTheme(),
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }

  ThemeData _buildTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: BakeryTheme.primaryColor,
        brightness: Brightness.light,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
