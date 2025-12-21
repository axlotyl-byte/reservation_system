// lib/features/navigation/presentation/providers/navigation_provider.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservation_system/features/auth/presentation/providers/auth_provider.dart';
import 'package:reservation_system/features/user/domain/entities/user.dart'; // Import for UserRole


/// --------------------
/// BottomNavItem Model
/// --------------------
class BottomNavItem {
  final String id;
  final String label;
  final IconData icon;
  final IconData activeIcon;
  final String routeName;
  final bool showBadge;

  const BottomNavItem({
    required this.id,
    required this.label,
    required this.icon,
    required this.activeIcon,
    required this.routeName,
    this.showBadge = false,
  });
}

/// --------------------
/// Navigation Analytics
/// --------------------
class NavigationAnalytics {
  final Map<String, int> _featureCounts = {
    'home': 0,
    'menu': 0,
    'cart': 0,
    'orders': 0,
    'notifications': 0,
    'profile': 0,
    'dashboard': 0,
    'order_management': 0,
    'inventory': 0,
  };

  void trackFeatureUsage(String feature) {
    if (_featureCounts.containsKey(feature)) {
      _featureCounts[feature] = _featureCounts[feature]! + 1;
    }
  }

  List<String> getTopFeatures({
    required UserRole userRole,
    int limit = 5,
  }) {
    final availableFeatures = _getAvailableFeatures(userRole);

    final sorted = availableFeatures.toList()
      ..sort((a, b) => _featureCounts[b]!.compareTo(_featureCounts[a]!));

    return sorted.take(limit).toList();
  }

  Set<String> _getAvailableFeatures(UserRole userRole) {
    switch (userRole) {
      case UserRole.client:
        return {
          'home',
          'menu',
          'cart',
          'orders',
          'notifications',
          'profile',
        };
      case UserRole.admin:
        return {
          'dashboard',
          'order_management',
          'inventory',
          'notifications',
          'profile',
        };
    }
  }

  void reset() {
    _featureCounts.updateAll((key, value) => 0);
  }
}

/// --------------------
/// Providers
/// --------------------
final navigationAnalyticsProvider =
    Provider<NavigationAnalytics>((ref) => NavigationAnalytics());

final frequentFeaturesProvider = Provider<List<String>>((ref) {
  final userRole = ref.watch(
    authProviderProvider.select((state) => state.userRole),
  );

  final analytics = ref.watch(navigationAnalyticsProvider);
  return analytics.getTopFeatures(userRole: userRole);
});

final bottomNavItemsProvider = Provider<List<BottomNavItem>>((ref) {
  final userRole = ref.watch(
    authProviderProvider.select((state) => state.userRole),
  );

  final frequentFeatures = ref.watch(frequentFeaturesProvider);
  return _getNavItemsForRole(userRole, frequentFeatures);
});

/// --------------------
/// Navigation Builder
/// --------------------
List<BottomNavItem> _getNavItemsForRole(
  UserRole userRole,
  List<String> frequentFeatures,
) {
  final allItems = {
    'home': const BottomNavItem(
      id: 'home',
      label: 'Home',
      icon: Icons.home_outlined,
      activeIcon: Icons.home,
      routeName: 'home',
    ),
    'menu': const BottomNavItem(
      id: 'menu',
      label: 'Menu',
      icon: Icons.menu_book_outlined,
      activeIcon: Icons.menu_book,
      routeName: 'menu',
    ),
    'cart': const BottomNavItem(
      id: 'cart',
      label: 'Cart',
      icon: Icons.shopping_cart_outlined,
      activeIcon: Icons.shopping_cart,
      routeName: 'cart',
      showBadge: true,
    ),
    'orders': const BottomNavItem(
      id: 'orders',
      label: 'Orders',
      icon: Icons.receipt_long_outlined,
      activeIcon: Icons.receipt_long,
      routeName: 'myOrders',
      showBadge: true,
    ),
    'notifications': const BottomNavItem(
      id: 'notifications',
      label: 'Alerts',
      icon: Icons.notifications_outlined,
      activeIcon: Icons.notifications,
      routeName: 'notifications',
      showBadge: true,
    ),
    'profile': const BottomNavItem(
      id: 'profile',
      label: 'Profile',
      icon: Icons.person_outlined,
      activeIcon: Icons.person,
      routeName: 'profile',
    ),
    'dashboard': const BottomNavItem(
      id: 'dashboard',
      label: 'Dashboard',
      icon: Icons.dashboard_outlined,
      activeIcon: Icons.dashboard,
      routeName: 'adminDashboard',
    ),
    'order_management': const BottomNavItem(
      id: 'order_management',
      label: 'Orders',
      icon: Icons.inventory_2_outlined,
      activeIcon: Icons.inventory_2,
      routeName: 'orderManagement',
      showBadge: true,
    ),
    'inventory': const BottomNavItem(
      id: 'inventory',
      label: 'Stock',
      icon: Icons.inventory_outlined,
      activeIcon: Icons.inventory,
      routeName: 'inventory',
    ),
  };

  switch (userRole) {
    case UserRole.client:
      return frequentFeatures
          .where(allItems.containsKey)
          .take(5)
          .map((f) => allItems[f]!)
          .toList();

    case UserRole.admin:
      return [
        allItems['dashboard']!,
        allItems['order_management']!,
        allItems['inventory']!,
        allItems['notifications']!,
        allItems['profile']!,
      ];
  }
}
