import 'package:flutter/material.dart';

class NotificationTab extends StatelessWidget {
  const NotificationTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white, // White background
      child: Center(
        child: Text('Notification Tab', style: TextStyle(fontSize: 12)),
      ),
    );
  }
}
