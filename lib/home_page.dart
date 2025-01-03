import 'package:flutter/material.dart';
import 'package:khata_book/customer_details.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Khata Book',style: TextStyle(fontSize: 26),),
      ),
      body: const Center(
        child: Text('Welcome to the home page!'),
      ),
      floatingActionButton: FloatingActionButton.extended(
      onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CustomerDetail()),
          );
        },
        label: const Text('Add Customer'),
        icon: const Icon(Icons.person_add), 
      ),
    );
  }
}

