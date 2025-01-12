import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khata_book/core/database_service.dart';
import 'package:khata_book/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

void test(){

  DatabaseService databaseService = DatabaseService.instance;
  DatabaseService databaseService2 = DatabaseService.instance;
  DatabaseService databaseService3 = DatabaseService.instance;
  DatabaseService databaseService4 = DatabaseService.instance;

}