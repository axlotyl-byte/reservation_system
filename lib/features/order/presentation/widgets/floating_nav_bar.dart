// lib/features/navigation/presentation/widgets/floating_nav_bar.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservation_system/features/order/presentation/providers/navigation_provider.dart';

class FloatingNavBar extends ConsumerWidget {
  final String currentRoute;
  final ValueChanged<String> onItemTap;

  const FloatingNavBar({
    super.key,
    required this.currentRoute,
    required this.onItemTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navItems = ref.watch(bottomNavItemsProvider);

    // Temporary values - will replace with providers later
    final cartCount = 0;
    final pendingOrdersCount = 0;

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: navItems.map((item) {
          final isSelected = item.routeName == currentRoute;
          final badgeCount = item.showBadge
              ? _getBadgeCount(item.id, cartCount, pendingOrdersCount)
              : 0;

          return FloatingNavItem(
            item: item,
            isSelected: isSelected,
            badgeCount: badgeCount,
            onTap: () => onItemTap(item.routeName),
          );
        }).toList(),
      ),
    );
  }

  int _getBadgeCount(String itemId, int cartCount, int pendingOrders) {
    switch (itemId) {
      case 'cart':
        return cartCount;
      case 'orders':
        return pendingOrders;
      default:
        return 0;
    }
  }
}

// Change from _FloatingNavItem to FloatingNavItem (remove the underscore)
class FloatingNavItem extends StatelessWidget {
  final dynamic item; // Use dynamic if BottomNavItem type is causing issues
  final bool isSelected;
  final int badgeCount;
  final VoidCallback onTap;

  const FloatingNavItem({
    super.key, // Add this
    required this.item,
    required this.isSelected,
    required this.badgeCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = isSelected
        ? theme.colorScheme.primary
        : theme.colorScheme.onSurface.withOpacity(0.6);

    // Safely access properties
    final icon = _getIcon(item, 'icon');
    final activeIcon = _getIcon(item, 'activeIcon');

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? theme.colorScheme.primary.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Icon(
              isSelected ? activeIcon : icon,
              color: color,
              size: 24,
            ),
            if (badgeCount > 0)
              Positioned(
                top: -4,
                right: -4,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  constraints: const BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.error,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    badgeCount > 9 ? '9+' : badgeCount.toString(),
                    style: TextStyle(
                      color: theme.colorScheme.onError,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  IconData _getIcon(dynamic item, String property) {
    try {
      // Try different ways to access the icon property
      if (item == null) return Icons.error;

      if (property == 'icon') {
        return item.icon as IconData? ?? Icons.error;
      } else if (property == 'activeIcon') {
        return item.activeIcon as IconData? ??
            item.icon as IconData? ??
            Icons.error;
      }

      return Icons.error;
    } catch (e) {
      return Icons.error;
    }
  }
}
