import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  final String email;
  const Home({required this.email, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 16),
            Text(
              email,
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}
