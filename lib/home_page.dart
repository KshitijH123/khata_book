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
  List<Map<String, dynamic>> filteredTransactions = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredTransactions = transactions;
    _searchController.addListener(_filterTransactions);
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
      filteredTransactions = transactions;
    });
  }

  void deleteTransaction(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Delete'),
        content:
            const Text('Are you sure you want to delete this transaction?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                transactions.removeAt(index);
                filteredTransactions = transactions;
              });
              Navigator.of(context).pop();
            },
            child: const Text('Delete', style: TextStyle(color: Color.fromARGB(255, 243, 101, 101))),
          ),
        ],
      ),
    );
  }

  void navigateToEditTransaction(int index) async {
    final updatedTransaction = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            CustomerDetail(transaction: filteredTransactions[index]),
      ),
    );

    if (updatedTransaction != null) {
      setState(() {
        filteredTransactions[index] = updatedTransaction;
      });
    }
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
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  prefixIcon: const Icon(Icons.search_outlined),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredTransactions.length,
                itemBuilder: (context, index) {
                  final transaction = filteredTransactions[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: GestureDetector(
                      onTap: () =>
                          navigateToEditTransaction(index), 
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 12.0,
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  transaction['name'],
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ),
                              Text(
                                '\₹${transaction['amount']}',
                                style: TextStyle(
                                  color: transaction['isMoneyGiven']
                                      ? Colors.green
                                      : Colors.red,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Color.fromARGB(255, 237, 103, 93)),
                            onPressed: () => deleteTransaction(index),
                          ),
                        ),
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
