import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:reservation_system/features/auth/presentation/providers/auth_provider.dart';
import 'package:reservation_system/features/user/domain/entities/user.dart';
import 'package:reservation_system/features/order/presentation/providers/order_providers.dart';
import 'package:reservation_system/features/order/domain/entities/order.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userRole =
        ref.watch(authProviderProvider.select((state) => state.userRole));

    // For admin: Watch the order state to get orders
    final orderState = ref.watch(orderNotifierProvider);
    final allOrders = orderState.orders;

    // Filter pending orders for admin dashboard
    final pendingOrders = allOrders
        .where((order) => order.status.toLowerCase() == 'pending')
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sweet Delights Bakery'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Notifications feature coming soon')),
              );
            },
          ),
        ],
      ),
      body: userRole == UserRole.client
          ? _buildCustomerHome(context)
          : _buildAdminHome(context, ref, pendingOrders, orderState.isLoading,
              orderState.error),
    );
  }

  // ---------------- CUSTOMER HOME ----------------
  Widget _buildCustomerHome(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFeaturedProducts(context),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: _buildActionCard(
                    context,
                    icon: Icons.local_offer,
                    title: 'Special Offers',
                    onTap: () => _goToProducts(context),
                    color: Colors.orange.shade100,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildActionCard(
                    context,
                    icon: Icons.receipt_long,
                    title: 'My Orders',
                    onTap: () => _goToMyOrders(context),
                    color: Colors.green.shade100,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _buildRecentlyViewed(context),
        ],
      ),
    );
  }

  Widget _buildFeaturedProducts(BuildContext context) {
    final featuredProducts = [
      {'name': 'Chocolate Cake', 'price': 15, 'image': 'assets/cake_1.jpg'},
      {'name': 'Red Velvet Cake', 'price': 18, 'image': 'assets/cake_2.jpg'},
      {'name': 'Cheesecake', 'price': 20, 'image': 'assets/cake_3.jpg'},
      {'name': 'Carrot Cake', 'price': 16, 'image': 'assets/cake_4.jpg'},
      {'name': 'Strawberry Cake', 'price': 17, 'image': 'assets/cake_5.jpg'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Featured Cakes',
            style: Theme.of(context).textTheme.headlineSmall ??
                const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: featuredProducts.length,
            itemBuilder: (context, index) {
              final product = featuredProducts[index];
              return GestureDetector(
                onTap: () => _goToProductDetail(context, 'product_$index'),
                child: Container(
                  width: 150,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey.shade200,
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12),
                          ),
                          child: Image.asset(
                            product['image'] as String,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                              color: Colors.grey.shade300,
                              child: const Center(
                                child: Icon(Icons.cake,
                                    size: 50, color: Colors.grey),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '${product['name']} \$${product['price']}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildActionCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    required Color color,
  }) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: color,
          ),
          child: Column(
            children: [
              Icon(icon, size: 40),
              const SizedBox(height: 8),
              Text(
                title,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecentlyViewed(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        'Recently Viewed',
        style: Theme.of(context).textTheme.headlineSmall ??
            const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  // ---------------- ADMIN HOME ----------------
  Widget _buildAdminHome(
    BuildContext context,
    WidgetRef ref,
    List<Order> pendingOrders,
    bool isLoading,
    String? error,
  ) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (error != null && error.isNotEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text('Error: $error'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => ref
                  .read(orderNotifierProvider.notifier)
                  .loadAllOrders(),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    return _buildAdminHomeContent(context, ref, pendingOrders);
  }

  Widget _buildAdminHomeContent(
      BuildContext context, WidgetRef ref, List<Order> pendingOrders) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAdminStats(),
          const SizedBox(height: 16),
          _buildTodaysOrders(context, ref, pendingOrders),
          const SizedBox(height: 16),
          _buildAdminQuickActions(context),
        ],
      ),
    );
  }

  Widget _buildAdminStats() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: [
          _buildStatCard(
              title: 'Pending Orders', value: '5', color: Colors.orange),
          _buildStatCard(
              title: 'Today\'s Revenue', value: '\$1,250', color: Colors.green),
          _buildStatCard(
              title: 'Completed Orders', value: '24', color: Colors.blue),
          _buildStatCard(
              title: 'New Customers', value: '8', color: Colors.purple),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required Color color,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value,
              style: TextStyle(
                  fontSize: 24, fontWeight: FontWeight.bold, color: color),
            ),
            const SizedBox(height: 8),
            Text(title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14, color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _buildTodaysOrders(BuildContext context, WidgetRef ref, List<Order> orders) {
    final displayOrders = orders.isEmpty ? [] : orders.take(3).toList();

    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Pending Orders (${orders.length})',
                    style: Theme.of(context).textTheme.titleLarge),
                TextButton(
                    onPressed: () => _goToOrderManagement(context),
                    child: const Text('View All')),
              ],
            ),
            const SizedBox(height: 16),
            if (displayOrders.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('No pending orders'),
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: displayOrders.length,
                itemBuilder: (context, index) {
                  final order = displayOrders[index];
                  final orderId = order.id;
                  final orderIdDisplay = orderId.length > 8
                      ? '${orderId.substring(0, 8)}...'
                      : orderId;
                  return ListTile(
                    leading: CircleAvatar(child: Text('#${index + 1}')),
                    title: Text('Order #$orderIdDisplay'),
                    subtitle: Text(
                        'Pickup: ${_formatDate(order.pickupDate ?? DateTime.now())}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.arrow_forward),
                      onPressed: () => _goToOrderDetail(context, order.id),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdminQuickActions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Quick Actions', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _buildQuickActionButton(context,
                  icon: Icons.add_circle,
                  label: 'New Product',
                  onTap: () => _goToAddProduct(context)),
              _buildQuickActionButton(context,
                  icon: Icons.inventory,
                  label: 'Inventory',
                  onTap: () => _goToInventory(context)),
              _buildQuickActionButton(context,
                  icon: Icons.people,
                  label: 'Customers',
                  onTap: () => _goToCustomerList(context)),
              _buildQuickActionButton(context,
                  icon: Icons.settings,
                  label: 'Settings',
                  onTap: () => _goToSettings(context)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionButton(BuildContext context,
      {required IconData icon,
      required String label,
      required VoidCallback onTap}) {
    return SizedBox(
      width: 100,
      child: Card(
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Icon(icon, size: 32),
                const SizedBox(height: 8),
                Text(label,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 12)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to format date
  String _formatDate(DateTime date) {
    return '${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }

  // ---------- Navigation Methods ----------
  // Using GoRouter for navigation

  void _goToProducts(BuildContext context) {
    // Navigate to product list
    context.goNamed('products');
  }

  void _goToMyOrders(BuildContext context) {
    // Navigate to my orders
    context.goNamed('orders');
  }

  void _goToProductDetail(BuildContext context, String productId) {
    // Navigate to product detail
    context.goNamed('productDetail', pathParameters: {'id': productId});
  }

  void _goToOrderManagement(BuildContext context) {
    // Since you don't have an order management screen yet, navigate to orders
    // or show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Order Management feature coming soon')),
    );
    // Alternatively, navigate to orders screen for now
    // context.goNamed('orders');
  }

  void _goToOrderDetail(BuildContext context, String orderId) {
    // Navigate to order detail
    context.goNamed('orderDetail', pathParameters: {'id': orderId});
  }

  void _goToAddProduct(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Add Product feature coming soon')),
    );
  }

  void _goToInventory(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Inventory feature coming soon')),
    );
  }

  void _goToCustomerList(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Customer List feature coming soon')),
    );
  }

  void _goToSettings(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Settings feature coming soon')),
    );
  }
}