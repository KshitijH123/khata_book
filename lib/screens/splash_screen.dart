import 'dart:async';

import 'package:flutter/material.dart';
import 'package:khata_book/screens/home/home_page_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState  extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const HomePageScreen()),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Container(
     color: Colors.white70,
      child: Center(
       child: Image.asset('asset/images/blue.png',height: 200,width: 200,) ),
     ),
    );
  }
}