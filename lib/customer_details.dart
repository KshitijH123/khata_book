import 'package:flutter/material.dart';

class CustomerDetail extends StatelessWidget {
  const CustomerDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Detail'),
      ),
      body: const Center(
        child: Text('Enter customer details here.'),
      ),
    );
  }
}
