import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:reservation_system/theme/theme.dart';
import 'package:reservation_system/routes/app_routes.dart';

class OrderHistoryScreen extends ConsumerStatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  ConsumerState<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends ConsumerState<OrderHistoryScreen> {
  String _selectedFilter = 'all';

  final List<Map<String, dynamic>> _orders = [
    {
      'id': 'ORD-123456',
      'date': DateTime.now().subtract(const Duration(days: 1)),
      'status': 'completed',
      'items': [
        {'name': 'Chocolate Fudge Cake', 'quantity': 1, 'price': 34.99}
      ],
      'total': 37.79,
      'pickupTime': '2:00 PM',
    },
    {
      'id': 'ORD-123455',
      'date': DateTime.now().subtract(const Duration(days: 3)),
      'status': 'cancelled',
      'items': [
        {'name': 'Croissant', 'quantity': 2, 'price': 3.50},
        {'name': 'Blueberry Muffin', 'quantity': 1, 'price': 4.25},
      ],
      'total': 11.97,
      'pickupTime': '10:00 AM',
    },
    {
      'id': 'ORD-123454',
      'date': DateTime.now().subtract(const Duration(days: 7)),
      'status': 'completed',
      'items': [
        {'name': 'Sourdough Loaf', 'quantity': 1, 'price': 7.99},
      ],
      'total': 8.63,
      'pickupTime': '3:00 PM',
    },
    {
      'id': 'ORD-123453',
      'date': DateTime.now().subtract(const Duration(days: 14)),
      'status': 'completed',
      'items': [
        {'name': 'Custom Wedding Cake', 'quantity': 1, 'price': 299.99},
      ],
      'total': 323.99,
      'pickupTime': '1:00 PM',
    },
  ];

  List<Map<String, dynamic>> get _filteredOrders {
    if (_selectedFilter == 'all') return _orders;
    return _orders
        .where((order) => order['status'] == _selectedFilter)
        .toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'completed':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'cancelled':
        return Colors.red;
      case 'processing':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'completed':
        return Icons.check_circle;
      case 'pending':
        return Icons.pending;
      case 'cancelled':
        return Icons.cancel;
      case 'processing':
        return Icons.timer;
      default:
        return Icons.info;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'My Orders',
          style: BakeryTextStyles.appBarTitle(context),
        ),
      ),
      body: Column(
        children: [
          // Filter Chips
          Padding(
            padding: const EdgeInsets.all(BakerySpacing.md),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildFilterChip('all', 'All Orders'),
                  const SizedBox(width: BakerySpacing.sm),
                  _buildFilterChip('completed', 'Completed'),
                  const SizedBox(width: BakerySpacing.sm),
                  _buildFilterChip('pending', 'Pending'),
                  const SizedBox(width: BakerySpacing.sm),
                  _buildFilterChip('cancelled', 'Cancelled'),
                  const SizedBox(width: BakerySpacing.sm),
                  _buildFilterChip('processing', 'Processing'),
                ],
              ),
            ),
          ),

          // Orders List
          Expanded(
            child: _filteredOrders.isEmpty
                ? _buildEmptyState(context)
                : RefreshIndicator(
                    onRefresh: () async {
                      // TODO: Refresh orders
                      await Future.delayed(const Duration(seconds: 1));
                    },
                    child: ListView.builder(
                      padding: const EdgeInsets.all(BakerySpacing.md),
                      itemCount: _filteredOrders.length,
                      itemBuilder: (context, index) {
                        final order = _filteredOrders[index];
                        return _buildOrderCard(order, context);
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String value, String label) {
    return ChoiceChip(
      label: Text(label),
      selected: _selectedFilter == value,
      onSelected: (selected) {
        setState(() {
          _selectedFilter = value;
        });
      },
    );
  }

  Widget _buildOrderCard(Map<String, dynamic> order, BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: BakerySpacing.md),
      child: InkWell(
        onTap: () {
          context.push(
            AppRoute.orderTracking.path.replaceFirst(':orderId', order['id']),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(BakerySpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Order ID & Status
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(order['id'],
                      style: BakeryTextStyles.titleMedium(context)),
                  Chip(
                    label: Text(
                      order['status'].toString().toUpperCase(),
                      style: const TextStyle(color: Colors.white, fontSize: 10),
                    ),
                    backgroundColor: _getStatusColor(order['status']),
                    visualDensity: VisualDensity.compact,
                  ),
                ],
              ),
              const SizedBox(height: BakerySpacing.sm),
              // Date & Pickup Time
              Row(
                children: [
                  const Icon(Icons.calendar_today,
                      size: 14, color: Colors.grey),
                  const SizedBox(width: BakerySpacing.xs),
                  Text(
                    DateFormat('MMM d, yyyy').format(order['date']),
                    style: BakeryTextStyles.bodySmall(context)
                        .copyWith(color: Colors.grey),
                  ),
                  const SizedBox(width: BakerySpacing.md),
                  const Icon(Icons.access_time, size: 14, color: Colors.grey),
                  const SizedBox(width: BakerySpacing.xs),
                  Text(
                    order['pickupTime'],
                    style: BakeryTextStyles.bodySmall(context)
                        .copyWith(color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: BakerySpacing.md),
              // Items
              ...List<Widget>.generate((order['items'] as List).length,
                  (itemIndex) {
                final item = order['items'][itemIndex];
                return Padding(
                  padding: const EdgeInsets.only(bottom: BakerySpacing.xs),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${item['quantity']}x ${item['name']}',
                          style: BakeryTextStyles.bodyMedium(context)),
                      Text('\$${item['price'].toStringAsFixed(2)}',
                          style: BakeryTextStyles.bodyMedium(context)),
                    ],
                  ),
                );
              }),
              const Divider(height: BakerySpacing.md),
              // Total
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total', style: BakeryTextStyles.titleSmall(context)),
                  Text('\$${order['total'].toStringAsFixed(2)}',
                      style: BakeryTextStyles.productPrice(context)),
                ],
              ),
              const SizedBox(height: BakerySpacing.md),
              // Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        context.push(
                          AppRoute.orderTracking.path
                              .replaceFirst(':orderId', order['id']),
                        );
                      },
                      child: const Text('Track Order'),
                    ),
                  ),
                  const SizedBox(width: BakerySpacing.md),
                  if (order['status'] == 'completed')
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => _showReorderDialog(context, order),
                        child: const Text('Reorder'),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.receipt_long, size: 64, color: Colors.grey),
          const SizedBox(height: BakerySpacing.md),
          Text('No orders found', style: BakeryTextStyles.titleMedium(context)),
          const SizedBox(height: BakerySpacing.xs),
          Text(
            _selectedFilter == 'all'
                ? 'You haven\'t placed any orders yet'
                : 'No $_selectedFilter orders',
            style: BakeryTextStyles.bodySmall(context)
                .copyWith(color: Colors.grey),
          ),
          const SizedBox(height: BakerySpacing.md),
          ElevatedButton(
            onPressed: () => context.go(AppRoute.home.path),
            child: const Text('Browse Products'),
          ),
        ],
      ),
    );
  }

  void _showReorderDialog(BuildContext context, Map<String, dynamic> order) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reorder Items'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Add these items to your cart?'),
            const SizedBox(height: BakerySpacing.md),
            ...List<Widget>.generate((order['items'] as List).length, (index) {
              final item = order['items'][index];
              return ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.cake),
                title: Text(item['name']),
                subtitle: Text('Quantity: ${item['quantity']}'),
                trailing: Text('\$${item['price'].toStringAsFixed(2)}'),
              );
            }),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Add items to cart
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Items added to cart')),
              );
              context.go(AppRoute.checkout.path);
            },
            child: const Text('Add to Cart'),
          ),
        ],
      ),
    );
  }
}
