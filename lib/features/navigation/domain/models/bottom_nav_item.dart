import 'package:flutter/material.dart';

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
