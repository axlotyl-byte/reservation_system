import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';
import 'user_remote_data_source.dart';

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  UserRemoteDataSourceImpl({
    required this.auth,
    required this.firestore,
  });

  @override
  Future<UserModel> registerUser(UserModel user, String password) async {
    final credential = await auth.createUserWithEmailAndPassword(
      email: user.email,
      password: password,
    );
    final uid = credential.user!.uid;
    await firestore.collection('users').doc(uid).set(user.toJson());
    return UserModel(
      id: uid,
      name: user.name,
      email: user.email,
      role: user.role,
    );
  }

  @override
  Future<UserModel> loginUser(String email, String password) async {
    final credential = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return getUserProfile(credential.user!.uid);
  }

  @override
  Future<UserModel> getUserProfile(String userId) async {
    final doc = await firestore.collection('users').doc(userId).get();
    return UserModel.fromSnapshot(doc);
  }

  @override
  Future<UserModel> updateUserProfile(UserModel user) async {
    await firestore.collection('users').doc(user.id).update(user.toJson());
    return user;
  }
}
