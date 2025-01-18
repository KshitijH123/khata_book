import 'package:get/get.dart';
import 'package:khata_book/core/database_service.dart';
import 'package:khata_book/model/transaction_model.dart';

class TransactionListController extends GetxController {
  RxList<TransactionModel> transactions = <TransactionModel>[].obs;

  double get totalMoneyGiven {
    return transactions
        .where((transaction) => transaction.moneyGiven)
        .fold(0.0, (sum, transaction) => sum + transaction.amount);
  }

  double get totalMoneyToGive {
    return transactions
        .where((transaction) => !transaction.moneyGiven)
        .fold(0.0, (sum, transaction) => sum + transaction.amount);
  }

  Future<void> fetchAllTransactions() async {
    final fetchedTransactions =
        await DatabaseService.instance.fetchAllTransactions();
    transactions.value = fetchedTransactions ?? [];
  }

  Future<bool> deleteTransaction(TransactionModel transaction) async {
    bool success =
        await DatabaseService.instance.deleteTransaction(transaction);
    if (success) {
      transactions.remove(
          transaction); 
    }
    return success;
  }

  void updateTransaction(TransactionModel transaction) {
    int index = transactions.indexWhere((t) => t.id == transaction.id);
    if (index != -1) {
      transactions[index] = transaction; 
    }
  }
}
