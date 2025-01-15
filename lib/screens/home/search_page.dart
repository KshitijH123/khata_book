import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage(
      {super.key,
      required Null Function(dynamic refreshTransactionList) reserveCallback});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Search Transactions',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                      Radius.circular(15.0)), 
                ),
              ),
              onChanged: (query) {
              },
            ),
          ],
        ),
      ),
    );
  }
}
