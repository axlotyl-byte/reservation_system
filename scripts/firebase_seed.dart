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
    print('The system is ready for User Acceptance Testing.');
  } catch (e) {
    print('❌ Error during seeding: $e');
    rethrow;
  }
}
