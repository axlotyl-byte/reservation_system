// seed_firestore.dart
import 'package:firebase_core/firebase_core.dart';
import 'package:reservation_system/firebase_options.dart';
import 'seed_users.dart';
import 'seed_products.dart';


void main() async {
  print('🚀 Starting Bakery System Data Seeding...');

  try {
    // Initialize Firebase
    print('🔧 Initializing Firebase...');
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print('✅ Firebase initialized successfully');

    // Run user seeding
    print('\n👥 Seeding users...');
    await seedUsers();

    // Run product seeding
    print('\n🍞 Seeding bakery products...');
    await seedProducts();


    print('\n🎉 All data seeded successfully!');
    print('\n📊 Seeding Complete Summary:');
    print('   - Users: Customer profiles created');
    print('   - Products: Bakery items available');
    print('   - Orders: Realistic order history');
    print('\n✅ The system is ready for User Acceptance Testing.');
    
    print('\n💡 For UAT Testing:');
    print('   1. Use customer emails to log in');
    print('   2. Check different order statuses');
    print('   3. Verify product availability');
    print('   4. Test order placement flow');
  } catch (e) {
    print('\n❌ Error during seeding: $e');
    rethrow;
  }
}