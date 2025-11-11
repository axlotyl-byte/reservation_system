import '../models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> registerUser(UserModel user, String password);
  Future<UserModel> loginUser(String email, String password);
  Future<UserModel> getUserProfile(String userId);
  Future<UserModel> updateUserProfile(UserModel user);
}