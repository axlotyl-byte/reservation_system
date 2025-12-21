import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservation_system/features/user/domain/entities/user.dart';

class AuthState {
  final User? user;

  AuthState({this.user});

  UserRole get userRole => user?.role ?? UserRole.client;
}

class AuthProvider extends StateNotifier<AuthState> {
  AuthProvider() : super(AuthState());

  void setUser(User user) {
    state = AuthState(user: user);
  }
}

final authProviderProvider =
    StateNotifierProvider<AuthProvider, AuthState>((ref) => AuthProvider());
