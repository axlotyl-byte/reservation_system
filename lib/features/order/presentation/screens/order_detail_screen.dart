import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:reservation_system/features/order/presentation/providers/order_providers.dart';
import 'package:reservation_system/features/order/domain/entities/order.dart';
import 'package:reservation_system/features/order/domain/entities/order_item.dart';
import 'package:reservation_system/theme/theme.dart';
import 'package:reservation_system/theme/widgets.dart';

class OrderDetailScreen extends ConsumerStatefulWidget {
  final String orderId;

  const OrderDetailScreen({super.key, required this.orderId});

  @override
  ConsumerState<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends ConsumerState<OrderDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(orderNotifierProvider.notifier).loadOrderById(widget.orderId);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Assuming orderNotifierProvider contains the state with selected order
    final orderState = ref.watch(orderNotifierProvider);
    final order = orderState.selectedOrder;
    final isLoading = orderState.isLoading;
    final error = orderState.error;

    return Scaffold(
      appBar: AppBar(
        title: Text('Order #${widget.orderId.substring(0, 8)}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () => _shareOrderDetails(order),
          ),
        ],
      ),
      body: _buildContent(order, isLoading, error),
      bottomNavigationBar: order != null ? _buildActionButtons(order) : null,
    );
  }

  Widget _buildContent(Order? order, bool isLoading, String? error) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (error != null && error.isNotEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text('Error loading order',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Text(
                error,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => ref
                  .read(orderNotifierProvider.notifier)
                  .loadOrderById(widget.orderId),
              style: ElevatedButton.styleFrom(
                backgroundColor: BakeryTheme.primaryColor,
                foregroundColor: Colors.white,
              ),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (order == null) {
      return AppWidgets.emptyState(
        context: context,
        icon: Icons.receipt_long_outlined,
        title: 'Order Not Found',
        description: 'The order you\'re looking for doesn\'t exist',
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Order Status
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildStatusBadge(order.status),
                      Text(
                        'Order #${order.id.substring(0, 8)}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildStatusTimeline(order),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Order Items
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Order Items',
                      style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 12),
                  ...order.items.map((item) => _buildOrderItem(item)).toList(),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total',
                          style: Theme.of(context).textTheme.titleMedium),
                      _buildPriceDisplay(
                        price: order.totalAmount,
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: BakeryTheme.primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Delivery Details
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Pickup Details',
                      style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 12),
                  _buildLabeledValue(
                    label: 'Pickup Date & Time',
                    value: DateFormat('MMM dd, yyyy • hh:mm a')
                        .format(order.pickupDate ?? DateTime.now()),
                  ),
                  const SizedBox(height: 8),
                  _buildLabeledValue(
                    label: 'Order Date',
                    value: DateFormat('MMM dd, yyyy • hh:mm a')
                        .format(order.createdAt),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color backgroundColor;
    Color textColor;

    switch (status.toLowerCase()) {
      case 'pending':
        backgroundColor = Colors.orange.shade100;
        textColor = Colors.orange.shade800;
        break;
      case 'confirmed':
        backgroundColor = Colors.blue.shade100;
        textColor = Colors.blue.shade800;
        break;
      case 'preparing':
        backgroundColor = Colors.purple.shade100;
        textColor = Colors.purple.shade800;
        break;
      case 'ready':
        backgroundColor = Colors.green.shade100;
        textColor = Colors.green.shade800;
        break;
      case 'completed':
        backgroundColor = Colors.green.shade100;
        textColor = Colors.green.shade800;
        break;
      case 'cancelled':
        backgroundColor = Colors.red.shade100;
        textColor = Colors.red.shade800;
        break;
      default:
        backgroundColor = Colors.grey.shade100;
        textColor = Colors.grey.shade800;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }

  Widget _buildStatusTimeline(Order order) {
    final statusSteps = [
      'pending',
      'confirmed',
      'preparing',
      'ready',
      'completed'
    ];
    final currentIndex = statusSteps.indexOf(order.status.toLowerCase());
    final currentIndexSafe = currentIndex >= 0 ? currentIndex : 0;

    return Column(
      children: statusSteps.asMap().entries.map((entry) {
        final index = entry.key;
        final isCompleted = index <= currentIndexSafe;
        final isLast = index == statusSteps.length - 1;

        return Row(
          children: [
            // Timeline dot
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    isCompleted ? BakeryTheme.primaryColor : Colors.grey[300],
              ),
              child: isCompleted
                  ? const Icon(Icons.check, size: 12, color: Colors.white)
                  : null,
            ),

            // Timeline line (except for last item)
            if (!isLast)
              Expanded(
                child: Container(
                  height: 2,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  color:
                      isCompleted ? BakeryTheme.primaryColor : Colors.grey[300],
                ),
              ),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildOrderItem(OrderItem item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          // Item image placeholder
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.cake, color: Colors.grey),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.productName,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Qty: ${item.quantity}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    _buildPriceDisplay(price: item.total),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceDisplay({required double price, TextStyle? style}) {
    return Text(
      '\$${price.toStringAsFixed(2)}',
      style: style ?? Theme.of(context).textTheme.bodyMedium,
    );
  }

  Widget _buildLabeledValue({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(color: Colors.grey),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }

  Widget _buildActionButtons(Order order) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey[300]!)),
      ),
      child: Row(
        children: [
          if (order.status.toLowerCase() == 'completed')
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () => _reorder(order),
                icon: const Icon(Icons.repeat),
                label: const Text('Reorder'),
              ),
            ),
          if (order.status.toLowerCase() == 'completed')
            const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              onPressed: () => _contactSupport(order),
              style: ElevatedButton.styleFrom(
                backgroundColor: BakeryTheme.primaryColor,
                foregroundColor: Colors.white,
              ),
              child: const Text('Contact Support'),
            ),
          ),
        ],
      ),
    );
  }

  void _shareOrderDetails(Order? order) {
    if (order == null) return;
    // Implement share functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Share functionality coming soon!')),
    );
  }

  void _reorder(Order order) {
    context.go('/reorder/${order.id}');
  }

  void _contactSupport(Order order) {
    showModalBottomSheet(
      context: context,
      builder: (context) => ContactSupportSheet(orderId: order.id),
    );
  }
}

class ContactSupportSheet extends StatelessWidget {
  final String orderId;

  const ContactSupportSheet({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Contact Support',
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          Text('Order #${orderId.substring(0, 8)}',
              style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: 24),
          _buildContactOption(
            context,
            icon: Icons.call,
            title: 'Call Support',
            subtitle: '+1 (555) 123-4567',
            onTap: () => _callSupport(context),
          ),
          const SizedBox(height: 16),
          _buildContactOption(
            context,
            icon: Icons.message,
            title: 'Send Message',
            subtitle: 'support@sweetdelights.com',
            onTap: () => _sendMessage(context),
          ),
          const SizedBox(height: 16),
          _buildContactOption(
            context,
            icon: Icons.chat,
            title: 'Live Chat',
            subtitle: 'Available 9 AM - 6 PM',
            onTap: () => _openLiveChat(context),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: BakeryTheme.primaryColor),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }

  void _callSupport(BuildContext context) {
    // Implement phone call
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Call functionality coming soon!')),
    );
  }

  void _sendMessage(BuildContext context) {
    // Implement email
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Email functionality coming soon!')),
    );
  }

  void _openLiveChat(BuildContext context) {
    // Implement live chat
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Live chat coming soon!')),
    );
  }
}
