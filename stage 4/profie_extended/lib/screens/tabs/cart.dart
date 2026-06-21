import 'package:flutter/material.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white, // White background
      child: Center(child: Text('Cart Tab', style: TextStyle(fontSize: 12))),
    );
  }
}
