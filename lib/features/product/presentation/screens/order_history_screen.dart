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