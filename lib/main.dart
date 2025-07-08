import 'package:flutter/material.dart';
import 'package:vpn_app/Screens/HomeScreen.dart';
import 'package:vpn_app/Theme/DarkTheme.dart';
import 'package:vpn_app/Theme/LightTheme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      home: VPNApp(),
    );
  }
}
