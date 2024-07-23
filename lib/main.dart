import 'package:flutter/material.dart';

import 'app_pages/app_pages/bottom_nav.dart';
import 'app_pages/app_pages/contacts_screen.dart';
import 'app_pages/app_pages/home_page.dart';
import 'app_pages/app_pages/profile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blank Home Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Nav(),
    );
  }
}

