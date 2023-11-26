import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:m_coffee_v2/src/routing/app_routes.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  final _pages = AppRoutes.pages;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        selectedFontSize: 15,
        selectedIconTheme: IconThemeData(color: Color(0xFFFC6011)),
        selectedItemColor: Color(0xFFFC6011),
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w500),
        unselectedIconTheme: IconThemeData(
          color: Color(0xFF52616B),
        ),
        items: <BottomNavigationBarItem>[
          _bottomNavigationBarItem(
            Icons.home,
            'Home',
            Color(0xFFF0F5F9),
          ),
          _bottomNavigationBarItem(
            Icons.menu_book_sharp,
            'Menu',
            Color(0xFFF0F5F9),
          ),
          _bottomNavigationBarItem(
            Icons.shopping_cart_outlined,
            'Cart',
            Color(0xFFF0F5F9),
          ),
          _bottomNavigationBarItem(
            CupertinoIcons.person_fill,
            'Profile',
            Color(0xFFF0F5F9),
          ),
        ],
        currentIndex: _selectedIndex, //New
        onTap: _onItemTapped,
      ),
    );
  }
}

BottomNavigationBarItem _bottomNavigationBarItem(
    IconData icon, String label, Color backgroundColor) {
  return BottomNavigationBarItem(
    icon: Icon(icon),
    label: label,
    backgroundColor: backgroundColor,
  );
}
