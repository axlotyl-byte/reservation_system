import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:reservation_system/features/product/presentation/providers/auth_provider.dart';
import 'package:reservation_system/theme/theme.dart';
import 'package:reservation_system/routes/app_routes.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  Color _getRoleColor(String role) {
    switch (role.toLowerCase()) {
      case 'admin':
        return Colors.red.withOpacity(0.1);
      case 'customer':
        return Colors.green.withOpacity(0.1);
      case 'client':
        return Colors.blue.withOpacity(0.1);
      default:
        return Colors.grey.withOpacity(0.1);
    }
  }

  void _showLogoutDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sign Out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              await ref.read(authProvider.notifier).logout();
              context.go(AppRoute.home.path);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final user = authState.user;
    final isLoading = authState.isLoading;

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(BakerySpacing.md),
        child: Column(
          children: [
            // Profile Header
            Card(
              child: Padding(
                padding: const EdgeInsets.all(BakerySpacing.md),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.grey[200],
                      child: Icon(
                        Icons.person,
                        size: 40,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(width: BakerySpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user?.name ?? 'Guest User',
                            style: BakeryTextStyles.titleLarge(context),
                          ),
                          const SizedBox(height: BakerySpacing.xs),
                          Text(
                            user?.email ?? 'Not logged in',
                            style:
                                BakeryTextStyles.bodyMedium(context).copyWith(
                              color: Colors.grey,
                            ),
                          ),
                          if (user?.role != null)
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: BakerySpacing.xs),
                              child: Chip(
                                label: Text(
                                  user!.role.toUpperCase(),
                                  style: const TextStyle(fontSize: 12),
                                ),
                                backgroundColor: _getRoleColor(user.role),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: BakerySpacing.lg),

            // Menu Items
            Card(
              child: Column(
                children: [
                  _buildMenuItem(
                    icon: Icons.history,
                    title: 'Order History',
                    onTap: () => context.go(AppRoute.orderHistory.path),
                  ),
                  _buildDivider(),
                  _buildMenuItem(
                    icon: Icons.location_on,
                    title: 'Saved Addresses',
                    onTap: () {
                      // todo: Navigate to addresses
                      context.push('/addresses');
                    },
                  ),
                  _buildDivider(),
                  _buildMenuItem(
                    icon: Icons.notifications,
                    title: 'Notifications',
                    onTap: () {
                      // todo: Navigate to notifications
                      context.push('/notifications');
                    },
                  ),
                  _buildDivider(),
                  _buildMenuItem(
                    icon: Icons.settings,
                    title: 'Settings',
                    onTap: () {
                      // todo: Navigate to settings
                      context.push('/settings');
                    },
                  ),
                  _buildDivider(),
                  _buildMenuItem(
                    icon: Icons.help,
                    title: 'Help & Support',
                    onTap: () {
                      // todo: Navigate to help
                      context.push('/help');
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: BakerySpacing.lg),

            // Logout Button
            if (user != null)
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => _showLogoutDialog(context, ref),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                    side: const BorderSide(color: Colors.red),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Sign Out'),
                ),
              ),

            // Login Button (if not logged in)
            if (user == null)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => context.go(AppRoute.home.path),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Sign In'),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  Widget _buildDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Divider(height: 1),
    );
  }
}
