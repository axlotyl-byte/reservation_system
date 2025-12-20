// lib/features/navigation/presentation/screens/main_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:reservation_system/features/product/presentation/screens/product_list_screen.dart';
import 'package:reservation_system/features/product/presentation/screens/order_history_screen.dart';
import 'package:reservation_system/features/product/presentation/screens/checkout_screen.dart';
import 'package:reservation_system/features/product/presentation/screens/profile_screen.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  int _selectedIndex = 0;

  // Bottom navigation items
  static final List<NavigationItem> _navigationItems = [
    NavigationItem(
      label: 'Home',
      icon: Icons.home,
      activeIcon: Icons.home_filled,
      route: '/',
    ),
    NavigationItem(
      label: 'Orders',
      icon: Icons.receipt_long,
      activeIcon: Icons.receipt_long,
      route: '/my-orders',
    ),
    NavigationItem(
      label: 'Cart',
      icon: Icons.shopping_cart,
      activeIcon: Icons.shopping_cart_checkout,
      route: '/cart',
    ),
    NavigationItem(
      label: 'Profile',
      icon: Icons.person,
      activeIcon: Icons.person,
      route: '/profile',
    ),
  ];

  void _onItemTapped(int index) {
    // Only navigate if it's a different tab
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
      context.go(_navigationItems[index].route);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBody() {
    // Listen to route changes to update selected index
    final location = GoRouterState.of(context).matchedLocation;
    
    // Update selected index based on current route
    for (int i = 0; i < _navigationItems.length; i++) {
      if (location.startsWith(_navigationItems[i].route)) {
        if (_selectedIndex != i) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            setState(() {
              _selectedIndex = i;
            });
          });
        }
        break;
      }
    }

    // Return the screen based on current route
    switch (_selectedIndex) {
      case 0:
        return const ProductListScreen();
      case 1:
        return const OrderHistoryScreen();
      case 2:
        return const CheckoutScreen();
      case 3:
        return const ProfileScreen();
      default:
        return const ProductListScreen();
    }
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue[700],
        unselectedItemColor: Colors.grey[600],
        selectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 12,
        ),
        items: _navigationItems.map((item) {
          return BottomNavigationBarItem(
            icon: Icon(item.icon),
            activeIcon: Icon(item.activeIcon),
            label: item.label,
          );
        }).toList(),
      ),
    );
  }
}

class NavigationItem {
  final String label;
  final IconData icon;
  final IconData activeIcon;
  final String route;

  NavigationItem({
    required this.label,
    required this.icon,
    required this.activeIcon,
    required this.route,
  });
}