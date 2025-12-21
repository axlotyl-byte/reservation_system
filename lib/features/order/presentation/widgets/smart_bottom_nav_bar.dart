// SIMPLIFIED WORKING VERSION
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SmartBottomNavBar extends ConsumerStatefulWidget {
  final String currentRoute;
  final ValueChanged<int>? onItemSelected;

  const SmartBottomNavBar({
    super.key,
    required this.currentRoute,
    this.onItemSelected,
  });

  @override
  ConsumerState<SmartBottomNavBar> createState() => _SmartBottomNavBarState();
}

class _SmartBottomNavBarState extends ConsumerState<SmartBottomNavBar> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _updateSelectedIndex();
  }

  void _updateSelectedIndex() {
    // Simple route to index mapping
    final route = widget.currentRoute;
    if (route.contains('home')) {
      _selectedIndex = 0;
    } else if (route.contains('cart')) {
      _selectedIndex = 1;
    } else if (route.contains('orders')) {
      _selectedIndex = 2;
    } else if (route.contains('profile')) {
      _selectedIndex = 3;
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Simple navigation
    switch (index) {
      case 0:
        context.go('/home');
        break;
      case 1:
        context.go('/cart');
        break;
      case 2:
        context.go('/orders');
        break;
      case 3:
        context.go('/profile');
        break;
    }

    widget.onItemSelected?.call(index);
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: _selectedIndex,
      onDestinationSelected: _onItemTapped,
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Badge(
            label: Text('0'),
            child: Icon(Icons.shopping_cart_outlined),
          ),
          selectedIcon: Icon(Icons.shopping_cart),
          label: 'Cart',
        ),
        NavigationDestination(
          icon: Badge(
            label: Text('0'),
            child: Icon(Icons.receipt_outlined),
          ),
          selectedIcon: Icon(Icons.receipt),
          label: 'Orders',
        ),
        NavigationDestination(
          icon: Icon(Icons.person_outline),
          selectedIcon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}
