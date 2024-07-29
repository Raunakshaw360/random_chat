import 'package:flutter/material.dart';

import 'app_pages/app_pages/ai_page.dart';
import 'app_pages/app_pages/bottom_nav.dart';
import 'app_pages/app_pages/home_page.dart';


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
        scaffoldBackgroundColor: const Color(0xfffff3eb),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(
            color: Colors.black, // Ensure icons are also dark grey
          ),
          elevation: 0, // Remove shadow
        ),
      ),
      home:  MyHomePage(),
    );
  }
}
