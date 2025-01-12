import 'package:khata_book/model/database_key.dart';

class TransactionModel {
  final int? id;
  final String name;
  final String description;
  final double amount;
  final DateTime date;
  final String month;
  final bool moneyGiven;

  TransactionModel({
    this.id,
    required this.name,
    required this.description,
    required this.amount,
    required this.date,
    required this.month,
    required this.moneyGiven,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json[DatabaseKey.id],
      name: json[DatabaseKey.name],
      description: json[DatabaseKey.description],
      amount: json[DatabaseKey.amount],
      date: DateTime.parse(json[DatabaseKey.date]),
      month: json[DatabaseKey.month],
      moneyGiven: json[DatabaseKey.moneyGiven] == 1,
    );
  }

  Map<String, Object?> toJson() {
    return {
      DatabaseKey.id: id,
      DatabaseKey.name: name,
      DatabaseKey.description: description,
      DatabaseKey.amount: amount,
      DatabaseKey.date: date.toString(),
      DatabaseKey.month: month,
      DatabaseKey.moneyGiven: moneyGiven ? 1 : 0,
    };
  }
}
