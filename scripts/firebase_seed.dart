// scripts/firebase_seed.dart
import 'package:firebase_core/firebase_core.dart';
import 'package:reservation_system/firebase_options.dart';
import 'seed_users.dart';
import 'seed_products.dart';
import 'seed_orders.dart';

void main() async {
  print('''
  🚀 BAKERY PRE-ORDER SYSTEM - DATA SEEDING
  ==========================================
  This script will populate your Firebase Firestore with test data
  for User Acceptance Testing (UAT).
  
  Features included:
  • Test users (customers, staff, admin) with Firebase Authentication
  • Bakery products using your ProductModel structure
  • Sample orders using your OrderModel and OrderItemModel
  ==========================================
  ''');

  try {
    // Initialize Firebase
    print('🔧 Step 1: Initializing Firebase...');
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print('✅ Firebase initialized successfully\n');

    // Step 1: Create users (with actual authentication)
    print('👥 Step 2: Creating test users with authentication...');
    print('   This may take a moment as we create Firebase Auth users...\n');
    await seedUsers();
    print('\n✅ User seeding complete\n');

    // Small delay to ensure users are propagated to Firestore
    print('⏳ Waiting for user data to sync...');
    await Future.delayed(const Duration(seconds: 3));

    // Step 2: Create products
    print('🍞 Step 3: Seeding bakery products...');
    await seedProducts();
    print('\n✅ Product seeding complete\n');

    // Small delay to ensure products are available
    await Future.delayed(const Duration(seconds: 2));

    // Step 3: Create orders
    print('📦 Step 4: Creating sample orders...');
    print('   Creating orders with OrderModel and OrderItemModel...\n');
    await seedOrders();
    print('\n✅ Order seeding complete\n');

    print('''
  🎉 SEEDING COMPLETE!
  ====================
  
  ✅ Your Firebase Firestore is now populated with test data.
  
  📊 DATA SUMMARY:
  • Users: 6 test accounts with Firebase Authentication
  • Products: Various bakery items using ProductModel
  • Orders: 6 sample orders using OrderModel and OrderItemModel
  
  🔐 TEST CREDENTIALS:
  
  Admin Access:
    Email: admin@bakery.com
    Password: Admin123!
  
  Staff Access:
    Email: manager@bakery.com
    Password: Manager123!
    Email: baker@bakery.com
    Password: Baker123!
  
  Customer Accounts:
    Email: john.customer@example.com
    Password: Customer123!
    Email: sarah.customer@example.com
    Password: Customer456!
    Email: mike.customer@example.com
    Password: Customer789!
  
  📱 UAT TESTING SCENARIOS:
  
  1. ORDER MANAGEMENT TESTS:
     • ✅ GetOrderById: Use order-001 through order-006
     • ✅ GetAllOrders: View all 6 orders
     • ✅ GetCustomerOrders: Each customer has multiple orders
     • ✅ UpdateOrderStatus: Test status transitions
     • ✅ PlaceOrder: Use test products to create new orders
     • ✅ DeleteOrder: Test cancellation flow
  
  2. ORDER STATUS FLOW TESTING:
     • order-001: PENDING → Can be confirmed
     • order-002: CONFIRMED → Can be moved to preparing
     • order-003: PREPARING → Can be marked as ready
     • order-004: READY → Can be marked as completed
     • order-005: COMPLETED → View history
     • order-006: CANCELLED → View refund process
  
  3. DATA COMPATIBILITY:
     • ✅ Orders use OrderModel structure
     • ✅ Order items use OrderItemModel
     • ✅ Compatible with OrderModel.fromSnapshot()
     • ✅ Compatible with OrderItemModel.fromJson()
  
  💡 QUICK TESTING GUIDE:
  
  1. Test GetOrderById use case:
     - Use order-001 (pending order)
     - Use order-005 (completed order)
  
  2. Test GetCustomerOrders use case:
     - John Smith (customer-001) has orders: 001, 004
     - Sarah Johnson (customer-002) has orders: 002, 005
     - Mike Williams (customer-003) has orders: 003, 006
  
  3. Test order status updates:
     - Update order-001 from "pending" to "confirmed"
     - Update order-003 from "preparing" to "ready"
  
  🔄 To reset test data, simply run this script again.
  
  📍 Order IDs for testing:
     order-001, order-002, order-003, order-004, order-005, order-006
  ==========================================
  ''');
  } catch (e) {
    print('\n❌ ERROR DURING SEEDING:');
    print('=======================');
    print('Error: $e');
    print('\nStack Trace:');
    print(e.toString());
    print('\n💡 TROUBLESHOOTING:');
    print('1. Make sure Firebase is properly configured');
    print('2. Check your firebase_options.dart file');
    print('3. Verify internet connection');
    print('4. Ensure Firestore rules allow writes');
    print('5. Run "flutterfire configure" if not done already');
    print('6. Check that all required dependencies are in pubspec.yaml');
    rethrow;
  }
}
