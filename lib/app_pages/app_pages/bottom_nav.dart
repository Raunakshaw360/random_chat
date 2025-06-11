
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:random_chat/app_pages/app_pages/contacts_screen.dart';
import 'package:random_chat/app_pages/app_pages/profile.dart';

import 'home_page.dart';
//goo


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 1;

  final List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    ContactsScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: bg));
    return Scaffold(
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(
            height: 1,
            thickness: 0.3,
            color: Colors.grey.shade600,
          ),
          Container(
            color: Colors.black,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                _buildNavItem(
                  icon: Icons.home_outlined,
                  label: 'home',
                  index: 0,
                ),
                _buildNavItem(
                  icon: Icons.chat,
                  label: 'AI',
                  index: 1,
                ),
                _buildNavItem(
                  icon: Icons.person,
                  label: 'Profile',
                  index: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({required IconData icon, required String label, required int index}) {
    final bool isSelected = _selectedIndex == index;
    final Color color = isSelected ? Color(0xFFFFFFFF) : Colors.grey.shade600;
    final TextStyle textStyle = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      height: 0,
      color: color,

    );

    return InkWell(
      onTap: () => _onItemTapped(index),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(icon, size: 20, color: color),
            Text(label, style: textStyle),
          ],
        ),
      ),
    );
  }
}
