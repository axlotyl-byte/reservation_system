// lib/core/routing/route_config.dart
class RouteConfig {
  // Splash (optional)
  static const String splash = '/splash';

  // Main
  static const String home = '/';

  // Product
  static const String products = '/products';
  static const String productDetail = '/products/:id';

  // Cart
  static const String cart = '/cart';

  // Order
  static const String orders = '/orders';
  static const String orderDetail = '/orders/:id';
}
