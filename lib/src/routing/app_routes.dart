// app_routes.dart

import 'package:flutter/material.dart';
import 'package:m_coffee_v2/src/common_widgets/bottom_navigation_bart.dart';
import 'package:m_coffee_v2/src/features/home/presentation/home_screen.dart';
import 'package:m_coffee_v2/src/features/profile/presentation/profile_screen.dart';

class AppRoutes {
  static List pages = [
    HomeScreen(),
    Center(child: Text("Menu")),
    Center(child: Text("Cart")),
    ProfileScreen(),
  ];

  static const String init = '/';
  // static const String home = '/home';
  // static const String menu = '/menu';
  // static const String cart = '/cart';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case init:
        return MaterialPageRoute(builder: (_) => BottomNavBar());
      default:
        return MaterialPageRoute(builder: (_) => NotFoundPage());
    }
  }
}

class NotFoundPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Not Found'),
      ),
      body: Center(
        child: Text('Halaman tidak ditemukan'),
      ),
    );
  }
}
