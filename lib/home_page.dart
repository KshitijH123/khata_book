import 'package:flutter/material.dart';
import 'package:khata_book/customer_details.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Map<String, dynamic>> transactions = [];
  List<Map<String, dynamic>> filteredTransactions =
      [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredTransactions = transactions;
    _searchController
        .addListener(_filterTransactions); 
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterTransactions() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      filteredTransactions = transactions
          .where((transaction) =>
              transaction['name'].toLowerCase().contains(query))
          .toList();
    });
  }

  void addTransaction(Map<String, dynamic> transaction) {
    setState(() {
      transactions.add(transaction);
      filteredTransactions =
          transactions; 
    });
  }

  void deleteTransaction(int index) {
    setState(() {
      transactions.removeAt(index);
      filteredTransactions =
          transactions; 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Khata Book', style: TextStyle(fontSize: 26)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  labelText: 'Search',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  prefixIcon: const Icon(Icons.search),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredTransactions.length,
                itemBuilder: (context, index) {
                  final transaction = filteredTransactions[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 10),
                    elevation: 5,
                    child: ListTile(
                      title: Text(transaction['name']),
                      subtitle: Text(
                        '\$${transaction['amount'].toStringAsFixed(2)}',
                        style: TextStyle(
                          color: transaction['isMoneyGiven']
                              ? Colors.green
                              : Colors.black,
                        ),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => deleteTransaction(index),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final newTransaction = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CustomerDetail(),
            ),
          );
          if (newTransaction != null) {
            addTransaction(newTransaction);
          }
        },
        label: const Text('Add Customer'),
        icon: const Icon(Icons.person_add),
      ),
    );
  }
}
