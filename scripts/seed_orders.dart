// scripts/seed_orders.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reservation_system/features/order/domain/models/order_item_model.dart';
import 'package:reservation_system/features/order/domain/models/order_model.dart';

Future<void> seedOrders() async {
  final firestore = FirebaseFirestore.instance;
  final ordersCollection = firestore.collection('orders');

  print('📦 Seeding bakery orders for testing...');

  // First, get existing user IDs and product IDs
  print('   🔍 Fetching existing users and products...');

  final usersSnapshot = await firestore.collection('users').limit(3).get();
  final productsSnapshot =
      await firestore.collection('products').limit(5).get();

  if (usersSnapshot.docs.isEmpty) {
    print('⚠️  No users found. Please run seed_users.dart first.');
    return;
  }

  if (productsSnapshot.docs.isEmpty) {
    print('⚠️  No products found. Please run seed_products.dart first.');
    return;
  }

  final userIds = usersSnapshot.docs.map((doc) => doc.id).toList();
  final productDocs = productsSnapshot.docs;

  print('   👥 Found ${userIds.length} users');
  print('   🍞 Found ${productDocs.length} products');

  // Generate realistic dates
  final now = DateTime.now();
  final yesterday = now.subtract(const Duration(days: 1));
  final lastWeek = now.subtract(const Duration(days: 7));
  final tomorrow = now.add(const Duration(days: 1));
  final dayAfterTomorrow = now.add(const Duration(days: 2));

  // Create OrderModel instances matching your structure
  final sampleOrders = [
    // PENDING ORDER - Fresh order just placed
    OrderModel(
      id: 'order-001',
      customerId: userIds.isNotEmpty ? userIds[0] : 'customer-001',
      items: [
        OrderItemModel(
          productId: productDocs.isNotEmpty ? productDocs[0].id : 'prod-001',
          productName: 'Sourdough Loaf',
          quantity: 2,
          price: 7.99,
        ),
        OrderItemModel(
          productId: productDocs.length > 1 ? productDocs[1].id : 'prod-002',
          productName: 'Croissant',
          quantity: 4,
          price: 3.99,
        ),
      ],
      totalAmount: 31.94, // (2*7.99 + 4*3.99)
      status: 'pending',
      createdAt: now,
      pickupDate: dayAfterTomorrow,
    ),
    // CONFIRMED ORDER - Accepted by bakery
    OrderModel(
      id: 'order-002',
      customerId: userIds.length > 1 ? userIds[1] : 'customer-002',
      items: [
        OrderItemModel(
          productId: productDocs.length > 2 ? productDocs[2].id : 'prod-003',
          productName: 'Chocolate Fudge Cake',
          quantity: 1,
          price: 29.99,
        ),
        OrderItemModel(
          productId: productDocs.length > 3 ? productDocs[3].id : 'prod-004',
          productName: 'Apple Turnover',
          quantity: 3,
          price: 4.25,
        ),
      ],
      totalAmount: 42.74, // (29.99 + 3*4.25)
      status: 'confirmed',
      createdAt: lastWeek,
      pickupDate: lastWeek.add(const Duration(days: 1)),
    ),
    // PREPARING ORDER - Currently being made
    OrderModel(
      id: 'order-003',
      customerId: userIds.length > 2 ? userIds[2] : 'customer-003',
      items: [
        OrderItemModel(
          productId: productDocs.isNotEmpty ? productDocs[0].id : 'prod-001',
          productName: 'Sourdough Loaf',
          quantity: 1,
          price: 7.99,
        ),
        OrderItemModel(
          productId: productDocs.length > 4 ? productDocs[4].id : 'prod-005',
          productName: 'Whole Wheat Bread',
          quantity: 2,
          price: 6.50,
        ),
        OrderItemModel(
          productId: productDocs.length > 1 ? productDocs[1].id : 'prod-002',
          productName: 'Croissant',
          quantity: 6,
          price: 3.99,
        ),
      ],
      totalAmount: 44.93, // (7.99 + 2*6.50 + 6*3.99)
      status: 'preparing',
      createdAt: yesterday,
      pickupDate: tomorrow,
    ),
    // READY ORDER - Ready for pickup
    OrderModel(
      id: 'order-004',
      customerId: userIds.isNotEmpty ? userIds[0] : 'customer-001',
      items: [
        OrderItemModel(
          productId: productDocs.length > 3 ? productDocs[3].id : 'prod-004',
          productName: 'Apple Turnover',
          quantity: 4,
          price: 4.25,
        ),
        OrderItemModel(
          productId: productDocs.length > 1 ? productDocs[1].id : 'prod-002',
          productName: 'Croissant',
          quantity: 2,
          price: 3.99,
        ),
      ],
      totalAmount: 24.98, // (4*4.25 + 2*3.99)
      status: 'ready',
      createdAt: yesterday,
      pickupDate: now,
    ),
    // COMPLETED ORDER - Successfully picked up
    OrderModel(
      id: 'order-005',
      customerId: userIds.length > 1 ? userIds[1] : 'customer-002',
      items: [
        OrderItemModel(
          productId: productDocs.length > 2 ? productDocs[2].id : 'prod-003',
          productName: 'Chocolate Fudge Cake',
          quantity: 1,
          price: 29.99,
        ),
      ],
      totalAmount: 29.99,
      status: 'completed',
      createdAt: lastWeek,
      pickupDate: lastWeek.add(const Duration(days: 2)),
    ),
    // CANCELLED ORDER - Customer cancelled
    OrderModel(
      id: 'order-006',
      customerId: userIds.length > 2 ? userIds[2] : 'customer-003',
      items: [
        OrderItemModel(
          productId: productDocs.length > 4 ? productDocs[4].id : 'prod-005',
          productName: 'Whole Wheat Bread',
          quantity: 3,
          price: 6.50,
        ),
        OrderItemModel(
          productId: productDocs.length > 3 ? productDocs[3].id : 'prod-004',
          productName: 'Apple Turnover',
          quantity: 2,
          price: 4.25,
        ),
      ],
      totalAmount: 28.00, // (3*6.50 + 2*4.25)
      status: 'cancelled',
      createdAt: lastWeek,
      pickupDate: lastWeek.add(const Duration(days: 1)),
    ),
  ];

  int createdCount = 0;
  int updatedCount = 0;
  int errorCount = 0;

  for (final order in sampleOrders) {
    try {
      // Convert to JSON using your OrderModel.toJson() method
      final orderJson = order.toJson();

      // Add additional fields that might be needed for display
      final enhancedJson = Map<String, dynamic>.from(orderJson);

      // Add customer information for easier testing
      final customerIndex = order.customerId == userIds[0]
          ? 0
          : order.customerId == userIds[1]
              ? 1
              : 2;

      enhancedJson.addAll({
        'customerName': [
          'John Smith',
          'Sarah Johnson',
          'Mike Williams'
        ][customerIndex],
        'customerEmail': [
          'john.customer@example.com',
          'sarah.customer@example.com',
          'mike.customer@example.com'
        ][customerIndex],
        'customerPhone': [
          '+1 (555) 123-4567',
          '+1 (555) 987-6543',
          '+1 (555) 456-7890'
        ][customerIndex],
        'orderNumber': 'BAK-2024-00${sampleOrders.indexOf(order) + 1}',
        'notes': _getOrderNotes(order.id),
        'paymentMethod': 'credit_card',
        'paymentStatus': order.status == 'cancelled' ? 'refunded' : 'paid',
      });

      // Check if order already exists
      final orderRef = ordersCollection.doc(order.id);
      final existingDoc = await orderRef.get();

      if (existingDoc.exists) {
        // Update existing order
        await orderRef.update(enhancedJson);
        updatedCount++;
        print('   🔄 Updated order: ${enhancedJson['orderNumber']}');
      } else {
        // Create new order
        await orderRef.set(enhancedJson);
        createdCount++;

        // Format items summary
        final itemSummary = order.items
            .map((item) => '${item.quantity}x ${item.productName}')
            .join(', ');

        print(
            '   ✅ Created order: ${enhancedJson['orderNumber']} (${order.status})');
        print('      👤 ${enhancedJson['customerName']}');
        print('      💰 \$${order.totalAmount}');
        print(
            '      📅 ${order.pickupDate?.toString().substring(0, 10) ?? "No date"}');
        print('      🛒 $itemSummary');
        if (enhancedJson['notes'] != null &&
            enhancedJson['notes'].toString().isNotEmpty) {
          print('      📝 ${enhancedJson['notes']}');
        }
      }

      await Future.delayed(const Duration(milliseconds: 200));
    } catch (e) {
      print('   ❌ Error with order ${order.id}: $e');
      errorCount++;
    }
  }

  print('\n📊 ORDER SEEDING SUMMARY');
  print('========================');
  print('• Total orders processed: ${sampleOrders.length}');
  print('• Created: $createdCount');
  print('• Updated: $updatedCount');
  print('• Errors: $errorCount');

  print('\n📋 Order Status Distribution:');
  final statusCounts = <String, int>{};
  for (final order in sampleOrders) {
    statusCounts[order.status] = (statusCounts[order.status] ?? 0) + 1;
  }

  for (final entry in statusCounts.entries) {
    print('   - ${entry.key}: ${entry.value} order(s)');
  }

  print('\n💡 TESTING SCENARIOS:');
  print('   • Pending: Order awaiting confirmation');
  print('   • Confirmed: Bakery has accepted order');
  print('   • Preparing: Items currently being made');
  print('   • Ready: Order ready for pickup');
  print('   • Completed: Customer has picked up');
  print('   • Cancelled: Order cancelled with refund');

  print('\n🔗 Order IDs for testing:');
  print('   • Use these IDs to test GetOrderById:');
  for (final order in sampleOrders) {
    print('     - ${order.id} (${order.status})');
  }

  print('\n✅ All orders are compatible with your OrderModel.fromSnapshot()');
  print('   • Uses OrderItemModel for items');
  print(
      '   • Correct field names (customerId, totalAmount, createdAt, pickupDate)');
  print('   • Timestamps will be converted by Firestore');
}

String _getOrderNotes(String orderId) {
  final notesMap = {
    'order-001': 'Please slice the sourdough loaf',
    'order-002': 'Birthday cake - please write "Happy Birthday Sarah"',
    'order-003': 'For office meeting',
    'order-004': 'Afternoon snack',
    'order-005': 'Anniversary celebration',
    'order-006': 'Travel plans changed',
  };
  return notesMap[orderId] ?? '';
}
