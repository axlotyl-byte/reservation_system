// lib/main.dart
import 'package:flutter/material.dart';
import 'package:reservation_system/routes/app_routes.dart' as app_routes;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Reservation System',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      routerConfig: app_routes.AppRouter.router,
    );
  }
}
