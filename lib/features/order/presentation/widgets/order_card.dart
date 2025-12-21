import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reservation_system/features/order/domain/entities/order.dart';
import 'package:reservation_system/theme/theme.dart';
import 'package:reservation_system/theme/widgets.dart';

class OrderCard extends StatelessWidget {
  final Order order;
  final VoidCallback onTap;

  const OrderCard({
    super.key,
    required this.order,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with order ID and status
              _buildHeader(context),

              const SizedBox(height: 12),

              // Order items preview
              _buildOrderItemsPreview(context),

              const Divider(height: 24),

              // Footer with pickup time and total
              _buildFooter(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    // Safely get status string - handle different possible status formats
    final statusString = _getStatusString(order.status);
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Status badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: _getStatusColor(order.status),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            statusString,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        // Order ID
        Text(
          'Order #${_formatOrderId(order.id)}',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
              ),
        ),
      ],
    );
  }

  Widget _buildOrderItemsPreview(BuildContext context) {
    // Check if items exist - handle null or empty
    final items = order.items ?? [];
    if (items.isEmpty) {
      return const Text(
        'No items in this order',
        style: TextStyle(fontSize: 14, color: Colors.grey),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Show up to 2 items
        ...items.take(2).map((item) => _buildOrderItemPreview(item, context)).toList(),

        // Show "+ X more" if there are more than 2 items
        if (items.length > 2)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              '+ ${items.length - 2} more items',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildOrderItemPreview(dynamic item, BuildContext context) {
    // Safely extract item properties
    final productName = _getItemProperty(item, 'productName') ?? 'Unknown Product';
    final quantity = _getItemProperty(item, 'quantity') ?? 1;
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 4,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              '$productName x$quantity',
              style: Theme.of(context).textTheme.bodyMedium,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    // Safely handle pickup date
    final pickupDate = order.pickupDate ?? DateTime.now();
    final totalAmount = order.totalAmount ?? 0.0;
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pickup: ${DateFormat('MMM dd').format(pickupDate)}',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
            Text(
              'at ${DateFormat('hh:mm a').format(pickupDate)}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
          ],
        ),

        // Price display
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.green[50],
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            '\$${totalAmount.toStringAsFixed(2)}',
            style: const TextStyle(
              color: Colors.green,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  // Helper methods
  String _formatOrderId(String id) {
    if (id.isEmpty) return '00000000';
    return id.length >= 8 ? id.substring(0, 8) : id.padLeft(8, '0');
  }

  String _getStatusString(dynamic status) {
    if (status == null) return 'Unknown';
    
    // Handle different status formats
    if (status is String) return status;
    if (status is Enum) return status.name;
    if (status.toString().contains('.')) {
      return status.toString().split('.').last;
    }
    return status.toString();
  }

  Color _getStatusColor(dynamic status) {
    final statusStr = _getStatusString(status).toLowerCase();
    
    switch (statusStr) {
      case 'pending':
        return Colors.orange;
      case 'confirmed':
        return Colors.blue;
      case 'preparing':
        return Colors.purple;
      case 'ready':
        return Colors.green;
      case 'completed':
        return Colors.green[700] ?? Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  dynamic _getItemProperty(dynamic item, String property) {
    try {
      if (item == null) return null;
      
      // Try to access property
      if (item is Map) {
        return item[property];
      }
      
      // Try using reflection-like access
      switch (property) {
        case 'productName':
          return item.productName;
        case 'quantity':
          return item.quantity;
        case 'price':
          return item.price;
        default:
          return null;
      }
    } catch (e) {
      return null;
    }
  }
}