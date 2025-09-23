import 'package:amritha_ayurvedha/presentation/screens/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amritha Ayurvedha',
      theme: ThemeData(),
      home: const SplashScreen(),
    );
  }
}
