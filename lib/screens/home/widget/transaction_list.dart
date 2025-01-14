import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khata_book/model/transaction_model.dart';
import 'package:khata_book/screens/add/transactions/add_transaction_details_screen.dart';
import '../../../core/typedef_models.dart';
import '../controller/transaction_list_controller.dart';

class TransactionList extends StatefulWidget {
  const TransactionList({
    super.key,
    required this.reserveCallback,
  });

  final ReverseCallback reserveCallback;

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  final TransactionListController controller =
      Get.put(TransactionListController());

  @override
  void initState() {
    super.initState();
    controller.fetchAllTransactions();
    widget.reserveCallback(refreshScreen);
  }

  void refreshScreen() {
    controller.fetchAllTransactions();
    setState(() {});
  }

  void deleteTransaction(TransactionModel transaction) {
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
            onPressed: () async {
              await controller.deleteTransaction(transaction);
              WidgetsBinding.instance.addPostFrameCallback((_) {
                refreshScreen();
              });
              Get.back();
            },
            child: const Text('Delete',
                style: TextStyle(color: Color.fromARGB(255, 243, 101, 101))),
          ),
        ],
      ),
    );
  }

  void navigateToTransactionDetails(TransactionModel transaction) async {
    final updatedTransaction = await Get.to(
      () => AddTransactionDetailScreen(transaction: transaction),
    );

    if (updatedTransaction != null) {
      refreshScreen();
    }
  }

  Widget itemView(TransactionModel transaction) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
      child: Container(
        height: 80,
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          title: Text(
            transaction.name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            transaction.description,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 16,
            children: [
              Text(
                transaction.amount.toStringAsFixed(1),
                style: TextStyle(
                  fontSize: 18,
                  color: transaction.moneyGiven ? Colors.green : Colors.red,
                ),
              ),
              IconButton(
                onPressed: () => deleteTransaction(transaction),
                icon: const Icon(Icons.delete_forever_rounded,
                    color: Colors.redAccent),
              ),
            ],
          ),
          onTap: () => navigateToTransactionDetails(transaction),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final transactions = controller.transactions;

      if (transactions.isEmpty) {
        return const Center(child: Text('No transaction record available.'));
      }

      return ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          return itemView(transactions[index]);
        },
      );
    });
  }
}
