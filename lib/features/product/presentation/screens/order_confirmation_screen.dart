import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reservation_system/theme/theme.dart';
import 'package:intl/intl.dart';

class OrderConfirmationScreen extends StatelessWidget {
  final String? orderId;

  const OrderConfirmationScreen({super.key, this.orderId});

  @override
  Widget build(BuildContext context) {
    final orderNumber =
        orderId ?? 'ORD-${DateTime.now().millisecondsSinceEpoch}';
    final pickupDate = DateTime.now().add(const Duration(days: 1));
    final pickupTime = '2:00 PM';
    final formattedDate = DateFormat('EEEE, MMMM d, yyyy').format(pickupDate);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Confirmation'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Container(
              height: 200,
              color: BakeryTheme.primaryColor.withOpacity(0.1),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.check_circle,
                      size: 80,
                      color: BakeryTheme.primaryColor,
                    ),
                    const SizedBox(height: BakerySpacing.md),
                    Text(
                      'Order Confirmed!',
                      style: BakeryTextStyles.headlineMedium(context),
                    ),
                    const SizedBox(height: BakerySpacing.xs),
                    Text(
                      'Thank you for your order',
                      style: BakeryTextStyles.bodyLarge(context),
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(BakerySpacing.md),
              child: Column(
                children: [
                  // Order Details Card
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(BakerySpacing.md),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Order Details',
                                style: BakeryTextStyles.titleLarge(context),
                              ),
                              IconButton(
                                icon: const Icon(Icons.share),
                                onPressed: () => _shareOrderDetails(
                                  context,
                                  orderNumber,
                                  formattedDate,
                                  pickupTime,
                                ),
                              ),
                            ],
                          ),
                          const Divider(),
                          _buildDetailItem(
                            icon: Icons.receipt_long,
                            title: 'Order Number',
                            value: orderNumber,
                            isBold: true,
                          ),
                          _buildDetailItem(
                            icon: Icons.calendar_today,
                            title: 'Pickup Date',
                            value: formattedDate,
                          ),
                          _buildDetailItem(
                            icon: Icons.access_time,
                            title: 'Pickup Time',
                            value: pickupTime,
                          ),
                          _buildDetailItem(
                            icon: Icons.store,
                            title: 'Pickup Location',
                            value:
                                'Sweet Delights Bakery\n123 Bakery Street, City',
                            isMultiLine: true,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: BakerySpacing.lg),

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () =>
                              _navigateToOrderTracking(context, orderNumber),
                          child: const Text('Track Order'),
                        ),
                      ),
                      const SizedBox(width: BakerySpacing.md),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => _navigateToHome(context),
                          child: const Text('Back to Home'),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: BakerySpacing.md),

                  TextButton(
                    onPressed: () => _navigateToOrderHistory(context),
                    child: const Text('View Order History'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper Widgets

  Widget _buildDetailItem({
    required IconData icon,
    required String title,
    required String value,
    bool isBold = false,
    bool isMultiLine = false,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon),
      title: Text(title),
      subtitle: isMultiLine
          ? Text(value)
          : Text(
              value,
              style:
                  isBold ? const TextStyle(fontWeight: FontWeight.bold) : null,
            ),
    );
  }

  // Navigation

  void _navigateToOrderTracking(BuildContext context, String orderNumber) {
    context.push('/order-tracking/$orderNumber');
  }

  void _navigateToHome(BuildContext context) {
    context.go('/');
  }

  void _navigateToOrderHistory(BuildContext context) {
    context.push('/my-orders');
  }

  // Share

  void _shareOrderDetails(
    BuildContext context,
    String orderNumber,
    String pickupDate,
    String pickupTime,
  ) {
    final message = '''
Order Confirmation

Order Number: $orderNumber
Pickup Date: $pickupDate
Pickup Time: $pickupTime
Location: Sweet Delights Bakery

Thank you for your order!
''';

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
