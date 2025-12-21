import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservation_system/features/order/presentation/providers/order_providers.dart';
import 'package:reservation_system/theme/theme.dart';
import 'package:reservation_system/theme/widgets.dart';
import 'package:reservation_system/features/order/domain/entities/order.dart';
class OrderTrackingScreen extends ConsumerStatefulWidget {
  final String orderId;

  const OrderTrackingScreen({super.key, required this.orderId});

  @override
  ConsumerState<OrderTrackingScreen> createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends ConsumerState<OrderTrackingScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(orderNotifierProvider.notifier).loadOrderById(widget.orderId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final order = ref.watch(selectedOrderProvider);
    final isLoading = ref.watch(ordersLoadingProvider);
    final error = ref.watch(ordersErrorProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Track Order'),
      ),
      body: _buildContent(order, isLoading, error),
    );
  }

  Widget _buildContent(Order? order, bool isLoading, String? error) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (error != null || order == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            const Text('Unable to track order'),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Go Back'),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        // Map View (Placeholder)
        Container(
          height: 200,
          color: Colors.grey[200],
          child: const Center(
            child: Icon(Icons.map, size: 64, color: Colors.grey),
          ),
        ),

        // Order Details
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Order Status
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppWidgets.statusBadge(
                              context: context,
                              status: order.status,
                              fontSize: 14,
                            ),
                            Text(
                              'ETA: 30-45 mins',
                              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                color: BakeryTheme.primaryColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _buildDeliveryProgress(order.status),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Delivery Information
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Delivery Info', style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: 12),
                        _buildInfoRow(
                          Icons.person,
                          'Baker: Chef Michael',
                        ),
                        _buildInfoRow(
                          Icons.phone,
                          'Contact: +1 (555) 123-4567',
                        ),
                        _buildInfoRow(
                          Icons.location_on,
                          'Pickup Location: 123 Bakery St',
                        ),
                        if (order.pickupDate != null)
                          _buildInfoRow(
                            Icons.access_time,
                            'Pickup Time: ${_formatTime(order.pickupDate!)}',
                          ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: _contactBaker,
                        icon: const Icon(Icons.message),
                        label: const Text('Message Baker'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _callBaker,
                        icon: const Icon(Icons.call),
                        label: const Text('Call Baker'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: BakeryTheme.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDeliveryProgress(String status) {
    final steps = [
      {'status': 'Order Placed', 'icon': Icons.shopping_cart},
      {'status': 'Order Confirmed', 'icon': Icons.check_circle},
      {'status': 'Preparing', 'icon': Icons.restaurant},
      {'status': 'Ready for Pickup', 'icon': Icons.local_shipping},
      {'status': 'Completed', 'icon': Icons.done_all},
    ];

    final currentStatusIndex = steps.indexWhere((step) {
      final stepStatus =
          step['status']?.toString() ?? ''; // Convert to string safely
      return stepStatus.toLowerCase().contains(status.toLowerCase());
    });

    return Column(
      children: steps.asMap().entries.map((entry) {
        final index = entry.key;
        final step = entry.value;
        final isCompleted = index <= currentStatusIndex;
        final isCurrent = index == currentStatusIndex;

        return ListTile(
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isCompleted ? BakeryTheme.primaryColor : Colors.grey[300],
            ),
            child: Icon(
              step['icon'] as IconData? ?? Icons.circle,
              size: 20,
              color: isCompleted ? Colors.white : Colors.grey,
            ),
          ),
          title: Text(
            step['status'] as String? ??  'Order Step ${index + 1}',
            style: TextStyle(
              fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
              color: isCompleted ? Colors.black : Colors.grey,
            ),
          ),
          trailing: isCurrent
              ? const CircularProgressIndicator(strokeWidth: 2)
              : isCompleted
                  ? const Icon(Icons.check, color: Colors.green)
                  : null,
        );
      }).toList(),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: BakeryTheme.primaryColor),
          const SizedBox(width: 12),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }

  String _formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  void _contactBaker() {
    // Implement message functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Message functionality coming soon!')),
    );
  }

  void _callBaker() {
    // Implement phone call functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Call functionality coming soon!')),
    );
  }
}