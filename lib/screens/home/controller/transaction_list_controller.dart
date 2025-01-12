import 'package:get/get.dart';
import 'package:khata_book/core/database_service.dart';
import 'package:khata_book/model/transaction_model.dart';

class TransactionListController extends GetxController {

  Future<List<TransactionModel>?>? futureTransactions;

  Future<void> fetchAllTransactions() async {
    futureTransactions = DatabaseService.instance.fetchAllTransactions();
  }

  Future<bool> deleteTransaction(TransactionModel transaction) async {
    return await DatabaseService.instance.deleteTransaction(transaction);
  }
}
