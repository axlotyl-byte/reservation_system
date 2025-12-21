// lib/core/presentation/screens/splash_screen.dart
import 'package:flutter/material.dart';
import 'package:reservation_system/theme/theme.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BakeryTheme.lightTheme.scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo or Icon
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: BakeryTheme.primaryColor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Icon(
                Icons.cake,
                size: 60,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            // App Name
            Text(
              'Sweet Delights',
              style: BakeryTheme.lightTheme.textTheme.displaySmall?.copyWith(
                color: BakeryTheme.primaryColor,
              ),
            ),
            const SizedBox(height: 8),
            // Tagline
            Text(
              'Artisanal Bakery & Cafe',
              style: BakeryTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                color: BakeryTheme.textColorLight.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 48),
            // Loading Indicator
            SizedBox(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                color: BakeryTheme.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
