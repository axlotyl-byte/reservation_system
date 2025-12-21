part of 'app_routes.dart';

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
          (dynamic _) => notifyListeners(),
        );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

class RouteGuard {
  static bool hasAccess({
    required UserRole userRole,
    required List<UserRole>? allowedRoles,
  }) {
    if (allowedRoles == null) return true;
    return allowedRoles.contains(userRole);
  }

  static bool canAccessCustomerFeatures(UserRole role) {
    return role == UserRole.client; // Changed from .customer to .client
  }

  static bool canAccessAdminFeatures(UserRole role) {
    return role == UserRole.admin;
  }

  static bool canAccessStaffFeatures(UserRole role) {
    return role == UserRole.admin; // Removed .staff since it doesn't exist
  }
}
