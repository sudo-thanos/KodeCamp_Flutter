import 'package:flutter/material.dart';
import 'splash_screen.dart';
// import 'login.dart';
// import './screens/tabs/home.dart';
// import './screens/main_screen.dart';

void main() {
  runApp(const MyApp());
}

// AApp entry point
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Contains the main components o the app, like the title, the font, defines the splash screen as the entrypoint
  // Also disables the debug banner
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Cookpedia",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Nato Sans'),
      home: const SplashScreen(),
    );
  }
}
