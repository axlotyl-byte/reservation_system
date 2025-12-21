// lib/core/presentation/screens/main_layout.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:reservation_system/features/auth/presentation/providers/auth_provider.dart';
import 'package:reservation_system/features/order/presentation/providers/navigation_provider.dart';
import 'package:reservation_system/features/order/presentation/widgets/smart_bottom_nav_bar.dart';
import 'package:reservation_system/features/user/domain/entities/user.dart';

class MainLayout extends ConsumerWidget {
  final Widget child;
  final String currentRoute;

  const MainLayout({
    super.key,
    required this.child,
    required this.currentRoute,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userRole = ref.watch(authProviderProvider.select((state) => state.userRole));

    // Determine visibility based on current route and user role
    final showBottomNav = _shouldShowBottomNav(currentRoute, userRole);
    final showFAB = _shouldShowFAB(currentRoute, userRole);

    return Scaffold(
      body: child,
      bottomNavigationBar:
          showBottomNav ? _buildBottomNavBar(context, ref) : null,
      floatingActionButton: showFAB ? _buildFab(context) : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  bool _shouldShowBottomNav(String currentRoute, UserRole? userRole) {
    final hideRoutes = [
      'login',
      'register',
      'forgot-password',
      'splash',
      'checkout',
      'payment',
      'order-confirmation',
      'customize-product',
      'product-detail',
      'order-detail',
      'reorder',
    ];

    // Check if current route should hide nav
    for (final route in hideRoutes) {
      if (currentRoute.contains(route)) {
        return false;
      }
    }

    // Admins don't see bottom nav (they have different navigation)
    return userRole != UserRole.admin;
  }

  bool _shouldShowFAB(String currentRoute, UserRole? userRole) {
    // Only clients (customers) see FAB
    if (userRole != UserRole.client) {
      return false;
    }

    final hideFABRoutes = [
      'menu',
      'checkout',
      'payment',
      'order-confirmation',
      'customize-product',
      'product-detail',
      'reorder',
    ];

    // Check if current route should hide FAB
    for (final route in hideFABRoutes) {
      if (currentRoute.contains(route)) {
        return false;
      }
    }

    return true;
  }

  Widget _buildBottomNavBar(BuildContext context, WidgetRef ref) {
    void onItemSelected(int index) {
      final navItems = ref.read(bottomNavItemsProvider);
      if (index < navItems.length) {
        final item = navItems[index];
        context.goNamed(item.routeName);
      }
    }

    return SafeArea(
      child: SmartBottomNavBar(
        currentRoute: currentRoute,
        onItemSelected: onItemSelected,
      ),
    );
  }

  Widget _buildFab(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => context.goNamed('menu'),
      backgroundColor: Theme.of(context).primaryColor,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      elevation: 4,
      child: const Icon(Icons.menu_book, size: 28),
    );
  }
}
