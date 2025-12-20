// scripts/verify_orders.dart
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reservation_system/firebase_options.dart';
import 'package:reservation_system/features/order/domain/models/order_model.dart';

void main() async {
  print('🔍 Verifying order data compatibility...\n');

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    final firestore = FirebaseFirestore.instance;
    final ordersCollection = firestore.collection('orders');

    // Get all orders
    final ordersSnapshot = await ordersCollection.get();

    if (ordersSnapshot.docs.isEmpty) {
      print('⚠️  No orders found. Please run seed_orders.dart first.');
      return;
    }

    print('📊 Found ${ordersSnapshot.docs.length} orders\n');

    int compatibleCount = 0;
    int errorCount = 0;

    for (final doc in ordersSnapshot.docs) {
      try {
        // Try to parse using your OrderModel.fromSnapshot()
        final order = OrderModel.fromSnapshot(doc);

        print('✅ Order ${doc.id} is compatible:');
        print('   • Customer: ${order.customerId}');
        print('   • Status: ${order.status}');
        print('   • Items: ${order.items.length} items');
        print('   • Total: \$${order.totalAmount}');
        print('   • Created: ${order.createdAt}');
        if (order.pickupDate != null) {
          print('   • Pickup: ${order.pickupDate}');
        }
        print('');

        compatibleCount++;
      } catch (e) {
        print('❌ Order ${doc.id} has compatibility issues:');
        print('   Error: $e');
        print('   Data: ${doc.data()}');
        print('');
        errorCount++;
      }
    }

    print('\n📋 COMPATIBILITY REPORT:');
    print('======================');
    print('• Total orders: ${ordersSnapshot.docs.length}');
    print('• Compatible with OrderModel: $compatibleCount');
    print('• Incompatible: $errorCount');

    if (compatibleCount == ordersSnapshot.docs.length) {
      print('\n🎉 All orders are fully compatible with your OrderModel!');
      print('✅ Ready for testing GetAllOrders, GetOrderById, etc.');
    }
  } catch (e) {
    print('❌ Error verifying data: $e');
  }
}
