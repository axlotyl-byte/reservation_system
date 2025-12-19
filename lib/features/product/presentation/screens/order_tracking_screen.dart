import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reservation_system/theme/theme.dart';
import 'package:reservation_system/routes/app_routes.dart';


class OrderTrackingScreen extends StatefulWidget {
  final String orderId;

  const OrderTrackingScreen({super.key, required this.orderId});

  @override
  State<OrderTrackingScreen> createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
  final List<Map<String, dynamic>> _trackingSteps = [
    {
      'title': 'Order Placed',
      'description': 'Your order has been received',
      'time': 'Today, 10:30 AM',
      'completed': true,
      'icon': Icons.shopping_cart_checkout,
    },
    {
      'title': 'Order Confirmed',
      'description': 'We\'ve confirmed your order',
      'time': 'Today, 10:35 AM',
      'completed': true,
      'icon': Icons.check_circle,
    },
    {
      'title': 'Preparation Started',
      'description': 'Our bakers are preparing your order',
      'time': 'Today, 11:00 AM',
      'completed': true,
      'icon': Icons.restaurant,
    },
    {
      'title': 'In the Oven',
      'description': 'Your items are being baked',
      'time': 'Today, 11:30 AM',
      'completed': false,
      'icon': Icons.local_fire_department,
    },
    {
      'title': 'Quality Check',
      'description': 'Ensuring everything is perfect',
      'time': 'Estimated: 12:30 PM',
      'completed': false,
      'icon': Icons.verified,
    },
    {
      'title': 'Ready for Pickup',
      'description': 'Your order is ready!',
      'time': 'Estimated: 1:00 PM',
      'completed': false,
      'icon': Icons.emoji_events,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Order Tracking',
          style: BakeryTextStyles.appBarTitle(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(BakerySpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order Header
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
                          widget.orderId,
                          style: BakeryTextStyles.titleLarge(context),
                        ),
                        const Chip(
                          label: Text(
                            'IN PROGRESS',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          ),
                          backgroundColor: Colors.blue,
                        ),
                      ],
                    ),
                    const SizedBox(height: BakerySpacing.sm),
                    const Text('Estimated Pickup: Today, 1:00 PM'),
                    const SizedBox(height: BakerySpacing.sm),
                    const Text('Sweet Delights Bakery, 123 Bakery Street'),
                  ],
                ),
              ),
            ),

            const SizedBox(height: BakerySpacing.lg),

            // Progress Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: BakerySpacing.md),
              child: LinearProgressIndicator(
                value: 0.5, // This would be dynamic based on order progress
                backgroundColor: Colors.grey[200],
                color: BakeryTheme.primaryColor,
                minHeight: 8,
                borderRadius: BorderRadius.circular(4),
              ),
            ),

            const SizedBox(height: BakerySpacing.lg),

            // Tracking Timeline
            Text(
              'Order Status',
              style: BakeryTextStyles.titleLarge(context),
            ),
            const SizedBox(height: BakerySpacing.md),

            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _trackingSteps.length,
              separatorBuilder: (context, index) =>
                  const SizedBox(height: BakerySpacing.md),
              itemBuilder: (context, index) {
                final step = _trackingSteps[index];
                final isLast = index == _trackingSteps.length - 1;

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Timeline Icon
                    Column(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: step['completed']
                                ? BakeryTheme.primaryColor
                                : Colors.grey[300],
                          ),
                          child: Icon(
                            step['icon'],
                            color:
                                step['completed'] ? Colors.white : Colors.grey,
                            size: 20,
                          ),
                        ),
                        if (!isLast)
                          Container(
                            width: 2,
                            height: 40,
                            color: step['completed']
                                ? BakeryTheme.primaryColor
                                : Colors.grey[300],
                          ),
                      ],
                    ),
                    const SizedBox(width: BakerySpacing.md),
                    // Step Details
                    Expanded(
                      child: Card(
                        color: step['completed']
                            ? BakeryTheme.primaryColor.withOpacity(0.05)
                            : null,
                        child: Padding(
                          padding: const EdgeInsets.all(BakerySpacing.md),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    step['title'],
                                    style: BakeryTextStyles.titleMedium(context)
                                        .copyWith(
                                      color: step['completed']
                                          ? BakeryTheme.primaryColor
                                          : null,
                                    ),
                                  ),
                                  if (step['completed'])
                                    const Icon(
                                      Icons.check_circle,
                                      color: Colors.green,
                                      size: 16,
                                    ),
                                ],
                              ),
                              const SizedBox(height: BakerySpacing.xs),
                              Text(step['description']),
                              const SizedBox(height: BakerySpacing.xs),
                              Text(
                                step['time'],
                                style: BakeryTextStyles.bodySmall(context)
                                    .copyWith(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),

            const SizedBox(height: BakerySpacing.lg),

            // Order Details
            Card(
              child: Padding(
                padding: const EdgeInsets.all(BakerySpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order Details',
                      style: BakeryTextStyles.titleLarge(context),
                    ),
                    const SizedBox(height: BakerySpacing.md),
                    const ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.cake),
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

            // Contact Support
            Card(
              child: Padding(
                padding: const EdgeInsets.all(BakerySpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Need Help?',
                      style: BakeryTextStyles.titleLarge(context),
                    ),
                    const SizedBox(height: BakerySpacing.md),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.phone),
                      title: const Text('Call Us'),
                      subtitle: const Text('(555) 123-4567'),
                      onTap: () {
                        // TODO: Make phone call
                      },
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.message),
                      title: const Text('Message Us'),
                      subtitle: const Text('Get instant support'),
                      onTap: () {
                        // TODO: Open chat
                      },
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.store),
                      title: const Text('Visit Store'),
                      subtitle: const Text('123 Bakery Street, City'),
                      onTap: () {
                        // TODO: Open maps
                      },
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
                  child: OutlinedButton.icon(
                    onPressed: () {
                      // TODO: Cancel order
                      _showCancelDialog(context);
                    },
                    icon: const Icon(Icons.cancel),
                    label: const Text('Cancel Order'),
                  ),
                ),
                const SizedBox(width: BakerySpacing.md),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      context.push(AppRoute.orderHistory.path);
                    },
                    icon: const Icon(Icons.history),
                    label: const Text('View All Orders'),
                  ),
                ),
              ],
            ),

            const SizedBox(height: BakerySpacing.xl),
          ],
        ),
      ),
    );
  }

  void _showCancelDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel Order'),
        content: const Text(
          'Are you sure you want to cancel this order? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('No, Keep Order'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            onPressed: () {
              Navigator.pop(context);
              // TODO: Cancel order logic
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Order cancelled successfully'),
                  backgroundColor: Colors.red,
                ),
              );
              context.pop();
            },
            child: const Text('Yes, Cancel Order'),
          ),
        ],
      ),
    );
  }
}
