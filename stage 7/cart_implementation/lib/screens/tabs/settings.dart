import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  // Placeholder page
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white, // White background
      child: Center(
        child: Text('Settings Tab', style: TextStyle(fontSize: 12)),
      ),
    );
  }
}
