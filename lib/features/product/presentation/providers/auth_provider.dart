import 'package:flutter_riverpod/flutter_riverpod.dart';

class User {
  final String id;
  final String name;
  final String email;
  final String role;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });
}

class AuthState {
  final User? user;
  final bool isLoading;
  final String? error;

  const AuthState({
    this.user,
    this.isLoading = false,
    this.error,
  });

  AuthState copyWith({
    User? user,
    bool? isLoading,
    String? error,
  }) {
    return AuthState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class AuthController extends StateNotifier<AuthState> {
  AuthController() : super(const AuthState());

  // TODO: Implement authentication methods
  Future<void> login(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);
    // TODO: Implement login logic
    await Future.delayed(const Duration(seconds: 1));
    state = state.copyWith(
      user: User(
        id: '1',
        name: 'Test User',
        email: email,
        role: 'customer',
      ),
      isLoading: false,
    );
  }

  Future<void> logout() async {
    state = state.copyWith(user: null);
  }
}

final authProvider = StateNotifierProvider<AuthController, AuthState>(
  (ref) => AuthController(),
);
