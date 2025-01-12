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
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
          Color.fromARGB(255, 136, 167, 220),
          Color.fromARGB(255, 122, 192, 224),
          Color.fromARGB(255, 175, 224, 247)
        ],
        begin: Alignment.topLeft,
       end: Alignment.bottomRight,
        ),

      ),
      child: Center(
       child: Image.asset('asset/images/blue.png',height: 200,width: 200,) ),
     ),
    );
  }
}