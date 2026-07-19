import 'package:flutter/material.dart';
import 'tabs/home.dart';
import 'tabs/cart.dart';
// import 'tabs/profile.dart';
import 'tabs/notification.dart';
import 'tabs/settings.dart';
import '../views/profile_view.dart';
import '../bindings/profile_binding.dart';

class MainScreen extends StatefulWidget {
  final String email;
  final String? name;
  const MainScreen({this.email = '', this.name, super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

// This class handles the tab Ui and controls. From setup to styling. Its like the
// entry point for the whole tab pages.
class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    // ProfileView lives inside an IndexedStack, so it never goes through
    // GetPage routing - register its controller here instead.
    ProfileBinding().dependencies();
  }

  @override
  Widget build(BuildContext context) {
    // List of 5 tab screens
    final List<Widget> _screens = [
      Home(email: widget.email),
      const Cart(),
      ProfileView(),
      const NotificationTab(),
      const Settings(),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: _screens[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        iconSize: 28,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
