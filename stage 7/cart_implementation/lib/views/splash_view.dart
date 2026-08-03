import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/splash_controller.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              'https://i.ibb.co/S4DpXcDs/splash.png',
              width: 120,
              height: 120,
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.restaurant, size: 80);
              },
            ),
            const SizedBox(height: 20),

            const Text(
              'Book\'n Eat',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 60),

            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.red.shade400),
            ),
          ],
        ),
      ),
    );
  }
}
