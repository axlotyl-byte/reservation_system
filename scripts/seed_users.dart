import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reservation_system/features/user/domain/data/datasources/user_remote_data_source_impl.dart';
import 'package:reservation_system/features/user/domain/data/models/user_model.dart';
import 'package:reservation_system/features/user/domain/entities/user.dart';

/// Converts role String to UserRole enum
UserRole parseUserRole(String role) {
  return UserRole.values.byName(role);
}

Future<void> seedUsers() async {
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  final userDataSource =
      UserRemoteDataSourceImpl(auth: auth, firestore: firestore);

  print('📝 Creating test users for Bakery Pre-order System...');

  final testUsers = [
    {
      'name': 'Bakery Administrator',
      'email': 'admin@bakery.com',
      'password': 'Admin123!',
      'role': 'admin',
    },
    {
      'name': 'Shop Manager',
      'email': 'manager@bakery.com',
      'password': 'Manager123!',
      'role': 'staff',
    },
    {
      'name': 'Head Baker',
      'email': 'baker@bakery.com',
      'password': 'Baker123!',
      'role': 'staff',
    },
    {
      'name': 'John Smith',
      'email': 'john.customer@example.com',
      'password': 'Customer123!',
      'role': 'customer',
    },
    {
      'name': 'Sarah Johnson',
      'email': 'sarah.customer@example.com',
      'password': 'Customer456!',
      'role': 'customer',
    },
    {
      'name': 'Mike Williams',
      'email': 'mike.customer@example.com',
      'password': 'Customer789!',
      'role': 'customer',
    },
  ];

  int createdCount = 0;
  int skippedCount = 0;
  int errorCount = 0;

  for (final userData in testUsers) {
    try {
      final existingMethods =
          await auth.fetchSignInMethodsForEmail(userData['email']!);

      if (existingMethods.isNotEmpty) {
        print('⚠️  User already exists: ${userData['email']}');
        skippedCount++;
        continue;
      }

      final user = UserModel(
        id: '',
        name: userData['name']!,
        email: userData['email']!,
        role: parseUserRole(userData['role']!),
      );

      await userDataSource.registerUser(user, userData['password']!);

      print(
          '✅ Created ${userData['role']!.toUpperCase()}: ${userData['name']}');
      print(
          '   Email: ${userData['email']} | Password: ${userData['password']}');

      createdCount++;
      await Future.delayed(const Duration(milliseconds: 300));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        print('⚠️  Email already in use: ${userData['email']}');
        skippedCount++;
      } else {
        print(
            '❌ Firebase error for ${userData['email']}: ${e.code} - ${e.message}');
        errorCount++;
      }
    } catch (e) {
      print('❌ Unexpected error for ${userData['email']}: $e');
      errorCount++;
    }
  }

  print('\n📊 USER SEEDING SUMMARY');
  print('======================');
  print('• Total attempted: ${testUsers.length}');
  print('• Successfully created: $createdCount');
  print('• Already existed: $skippedCount');
  print('• Errors encountered: $errorCount');
}
