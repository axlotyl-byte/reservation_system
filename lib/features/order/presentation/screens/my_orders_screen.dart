import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:reservation_system/features/order/presentation/providers/order_providers.dart';
import 'package:reservation_system/features/order/presentation/widgets/order_card.dart';
import 'package:reservation_system/features/order/domain/entities/order.dart';
import 'package:reservation_system/theme/theme.dart';
import 'package:reservation_system/theme/widgets.dart';
import 'package:reservation_system/features/auth/presentation/providers/auth_provider.dart';

// Create a combined provider for this screen if needed
final myOrdersProvider = FutureProvider<List<Order>>((ref) async {
  final userId =
      ref.watch(authProviderProvider.select((state) => state.user?.id));
  if (userId == null) return [];

  final orders = ref.watch(ordersProvider);
  return orders;
});

class MyOrdersScreen extends ConsumerStatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  ConsumerState<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends ConsumerState<MyOrdersScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _orderStatuses = [
    'All',
    'Pending',
    'Confirmed',
    'Preparing',
    'Ready',
    'Completed',
    'Cancelled'
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _orderStatuses.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Order> _filterOrders(List<Order> orders, String status) {
    if (status == 'All') return orders;
    return orders
        .where(
            (order) => order.status.toLowerCase() == status.toLowerCase())
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final myOrdersAsync = ref.watch(myOrdersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          indicatorColor: BakeryTheme.primaryColor,
          labelColor: BakeryTheme.primaryColor,
          unselectedLabelColor: Colors.grey,
          tabs: _orderStatuses.map((status) => Tab(text: status)).toList(),
        ),
      ),
      body: SafeArea(
        child: myOrdersAsync.when(
          data: (orders) => _buildOrderList(orders),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 64, color: Colors.red),
                const SizedBox(height: 16),
                Text('Error loading orders',
                    style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Text(error.toString(),
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: Colors.grey)),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => ref.invalidate(myOrdersProvider),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: BakeryTheme.primaryColor,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOrderList(List<Order> orders) {
    return TabBarView(
      controller: _tabController,
      children: _orderStatuses.map((status) {
        final filteredOrders = _filterOrders(orders, status);

        if (filteredOrders.isEmpty) {
          return AppWidgets.emptyState(
            context: context,
            icon: Icons.receipt_long_outlined,
            title: status == 'All' ? 'No Orders Yet' : 'No $status Orders',
            description: status == 'All'
                ? 'Your order history will appear here'
                : 'You have no $status orders',
            action: status == 'All'
                ? ElevatedButton(
                    onPressed: () => context.go('/'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: BakeryTheme.primaryColor,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Browse Products'),
                  )
                : null,
          );
        }

        return RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(myOrdersProvider);
          },
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: filteredOrders.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final order = filteredOrders[index];
              return OrderCard(
                order: order,
                onTap: () => context.go('/order/${order.id}'),
              );
            },
          ),
        );
      }).toList(),
    );
  }
}
