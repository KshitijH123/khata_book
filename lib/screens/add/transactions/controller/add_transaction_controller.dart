import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khata_book/core/database_service.dart';
import 'package:khata_book/core/extension/date_time_extension.dart';
import 'package:khata_book/model/transaction_model.dart';

class AddTransactionController extends GetxController {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final amountController = TextEditingController();

  DateTime date = DateTime.now();
  bool moneyGiven = false;

  void initialize({TransactionModel? transaction}) {
    nameController.text = transaction?.name ?? '';
    descriptionController.text = transaction?.description ?? '';
    amountController.text = transaction?.amount.toStringAsFixed(1) ?? '';
    date = transaction?.date ?? DateTime.now();
    moneyGiven = transaction?.moneyGiven ?? false;
  }

  Future<bool> saveTransaction() async {
    final name = nameController.text.trim();
    final description = descriptionController.text.trim();
    final amount = double.tryParse(amountController.text.trim());

    final transaction = TransactionModel(
      name: name,
      description: description,
      amount: amount ?? 0.0,
      date: date,
      month: date.toStringMonth,
      moneyGiven: moneyGiven,
    );

    return await DatabaseService.instance.addTransaction(transaction);
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    amountController.dispose();
    super.dispose();
  }
}
