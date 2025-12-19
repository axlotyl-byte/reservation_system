import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reservation_system/theme/theme.dart';
import 'package:reservation_system/routes/app_routes.dart';
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

    return Scaffold(
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
                    Icon(
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
                                onPressed: () {
                                  // TODO: Share order details
                                },
                              ),
                            ],
                          ),
                          const Divider(),
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: const Icon(Icons.receipt_long),
                            title: const Text('Order Number'),
                            subtitle: Text(
                              orderNumber,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: const Icon(Icons.calendar_today),
                            title: const Text('Pickup Date'),
                            subtitle: Text(
                              DateFormat('EEEE, MMMM d, yyyy')
                                  .format(pickupDate),
                            ),
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: const Icon(Icons.access_time),
                            title: const Text('Pickup Time'),
                            subtitle: Text(pickupTime),
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: const Icon(Icons.store),
                            title: const Text('Pickup Location'),
                            subtitle: const Text(
                              'Sweet Delights Bakery\n123 Bakery Street, City',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: BakerySpacing.lg),

                  // Order Summary
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(BakerySpacing.md),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Order Summary',
                            style: BakeryTextStyles.titleLarge(context),
                          ),
                          const SizedBox(height: BakerySpacing.md),
                          // Order items
                          const ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  'https://images.unsplash.com/photo-1578986120-74d6921ce456'),
                            ),
                            title: Text('Chocolate Fudge Cake'),
                            subtitle: Text('Quantity: 1'),
                            trailing: Text('\$34.99'),
                          ),
                          const Divider(),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Subtotal'),
                              Text('\$34.99'),
                            ],
                          ),
                          const SizedBox(height: BakerySpacing.xs),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Tax (8%)'),
                              Text('\$2.80'),
                            ],
                          ),
                          const SizedBox(height: BakerySpacing.xs),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Payment Method'),
                              Text('Pay on Pickup'),
                            ],
                          ),
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total',
                                style: BakeryTextStyles.titleMedium(context),
                              ),
                              Text(
                                '\$37.79',
                                style: BakeryTextStyles.productPrice(context),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: BakerySpacing.lg),

                  // Next Steps
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(BakerySpacing.md),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'What\'s Next?',
                            style: BakeryTextStyles.titleLarge(context),
                          ),
                          const SizedBox(height: BakerySpacing.md),
                          const ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Icon(Icons.notifications_active),
                            title: Text('Order Confirmation'),
                            subtitle: Text(
                                'You\'ll receive a confirmation email shortly'),
                          ),
                          const ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Icon(Icons.timer),
                            title: Text('Preparation Time'),
                            subtitle:
                                Text('Your order will be ready in 2 hours'),
                          ),
                          const ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Icon(Icons.store),
                            title: Text('Pickup Reminder'),
                            subtitle: Text(
                                'We\'ll send you a reminder 30 minutes before pickup'),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: BakerySpacing.xl),

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            context
                                .push(AppRoute.orderTracking.path.replaceFirst(
                              ':orderId',
                              orderNumber,
                            ));
                          },
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: const Text('Track Order'),
                        ),
                      ),
                      const SizedBox(width: BakerySpacing.md),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            context.go(AppRoute.home.path);
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: const Text('Back to Home'),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: BakerySpacing.md),

                  TextButton(
                    onPressed: () {
                      context.push(AppRoute.orderHistory.path);
                    },
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
}
