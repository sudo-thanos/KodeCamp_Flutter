import 'package:flutter/material.dart';
import 'dart:async';
import 'profile_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;

  //Navigates to Profile screen after 3 seconds
  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ProfileScreen()),
      );
    });
  }

  // cancels the timer after nvigation
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  // This is the main Splash screen widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.red[400],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Image.asset('assets/splash.png', fit: BoxFit.contain),
            ),
            const SizedBox(height: 30),
            const Text(
              'Book\'n Eat',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 60),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.red.shade400),
            ),
            // Image.asset('assets/jump.svg', width: 80, height: 80),
          ],
        ),
      ),
    );
  }
}
