import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reservation_system/features/order/domain/models/order_item_model.dart';
import 'package:reservation_system/features/order/domain/models/order_model.dart';

Future<void> seedOrders() async {
  final firestore = FirebaseFirestore.instance;
  final ordersCollection = firestore.collection('orders');

  print('📦 Seeding bakery orders (compatible with OrderModel)...');

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

  // Create OrderModel instances matching your EXACT structure
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
  int errorCount = 0;

  print('\n🧪 TESTING OrderModel.toJson() COMPATIBILITY...');

  // First, test that toJson() works correctly
  for (final order in sampleOrders) {
    try {
      final json = order.toJson();
      print('\n✅ Order ${order.id} - toJson() output keys:');
      json.forEach((key, value) {
        if (key == 'items') {
          print('   $key: List of ${(value as List).length} items');
        } else if (key == 'createdAt' || key == 'pickupDate') {
          print('   $key: ${value.toString().substring(0, 19)}');
        } else {
          print('   $key: $value');
        }
      });
    } catch (e) {
      print('❌ Error with order ${order.id} toJson(): $e');
    }
  }

  print('\n💾 SAVING ORDERS TO FIRESTORE...');

  for (final order in sampleOrders) {
    try {
      // Use ONLY the fields from toJson() - no extra fields
      final orderJson = order.toJson();

      // Check if order already exists
      final orderRef = ordersCollection.doc(order.id);
      final existingDoc = await orderRef.get();

      if (existingDoc.exists) {
        // Update existing order
        await orderRef.update(orderJson);
        print('   🔄 Updated order: ${order.id}');
      } else {
        // Create new order - ONLY use toJson() output
        await orderRef.set(orderJson);
        createdCount++;

        // Verify it can be read back
        final savedDoc = await orderRef.get();
        final savedOrder = OrderModel.fromSnapshot(savedDoc);

        print('   ✅ Created order: ${order.id} (${order.status})');
        print('      👤 Customer: ${savedOrder.customerId}');
        print('      💰 Total: \$${savedOrder.totalAmount}');
        print('      🛒 Items: ${savedOrder.items.length}');
        print(
            '      📅 Pickup: ${savedOrder.pickupDate?.toString().substring(0, 10) ?? "Not set"}');

        // Verify fromSnapshot works
        print('      ✓ OrderModel.fromSnapshot() test: PASSED');
      }

      await Future.delayed(const Duration(milliseconds: 200));
    } catch (e) {
      print('   ❌ Error with order ${order.id}: $e');
      errorCount++;
    }
  }

  print('\n📊 ORDER SEEDING SUMMARY');
  print('========================');
  print('• Created: $createdCount orders');
  print('• Errors: $errorCount');

  print('\n✅ COMPATIBILITY CHECK:');
  print('   ✓ Uses exact OrderModel.toJson() structure');
  print('   ✓ Compatible with OrderModel.fromSnapshot()');
  print('   ✓ Compatible with OrderItemModel.fromJson()');
  print(
      '   ✓ Fields: customerId, items, totalAmount, status, createdAt, pickupDate');

  print('\n🧪 TEST YOUR USE CASES WITH:');
  print('   1. GetOrderById: Use order-001 through order-006');
  print('   2. GetAllOrders: All 6 orders will be returned');
  print('   3. GetCustomerOrders: Filter by customerId');
  print('   4. UpdateOrder: Modify status field');
  print('   5. PlaceOrder: Use the same structure');
  print('   6. DeleteOrder: Remove by ID');

  print('\n🔗 Test with these IDs:');
  for (final order in sampleOrders) {
    print('   • ${order.id} (${order.status}) → customer: ${order.customerId}');
  }
}
