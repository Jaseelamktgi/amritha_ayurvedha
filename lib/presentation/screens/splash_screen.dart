import 'dart:ui';
import 'package:amritha_ayurvedha/core/constants/font_strings.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(AssetsHelper.splashBg, fit: BoxFit.cover),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(color: Colors.black.withValues(alpha: 0)),
          ),
          Center(
            child: Image.asset(AssetsHelper.logo, width: 150, height: 150),
          ),
        ],
      ),
    );
  }
}
