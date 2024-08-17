import 'package:chat_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(SocialApp());
}

class SocialApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.pink,
        hintColor: Colors.red,
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.black),
        ),
      ),
      home: LoginScreen(),
    );
  }
}
