//Singleton class
import 'package:khata_book/model/transaction_model.dart';
import 'package:sqflite/sqflite.dart';

import '../model/database_key.dart';

class DatabaseService {
  static DatabaseService instance = DatabaseService._();

  DatabaseService._();

  Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await createDatabase();
    return _database;
  }

  Future<Database> createDatabase() async {
    final path = await getDatabasesPath();
    final absolutePath = '$path/${DatabaseKey.databaseName}';

    final database = await openDatabase(absolutePath, version: 1,
        onCreate: (Database db, int version) {
      db.execute('''
          CREATE TABLE ${DatabaseKey.tableName}(
          ${DatabaseKey.id} INTEGER PRIMARY KEY AUTOINCREMENT,        
          ${DatabaseKey.name} TEXT NOT NULL,  
          ${DatabaseKey.description} TEXT,
          ${DatabaseKey.amount} REAL,
          ${DatabaseKey.date} TEXT,
          ${DatabaseKey.month} TEXT,
          ${DatabaseKey.moneyGiven} INTEGER          
          )
          ''');
    });

    return database;
  }

  Future<List<TransactionModel>?> fetchAllTransactions() async {
    final database = await this.database;
    final result = await database?.query(DatabaseKey.tableName);

    return result?.map((json) => TransactionModel.fromJson(json)).toList();
  }

  Future<bool> addTransaction(TransactionModel transaction) async {
    final database = await this.database;
    final success =
        await database?.insert(DatabaseKey.tableName, transaction.toJson());

    return (success ?? 0) > 0;
  }

  Future<bool> deleteTransaction(TransactionModel transaction) async {
    final database = await this.database;
    final success = await database?.delete(DatabaseKey.tableName,
        where: '${DatabaseKey.id}=${transaction.id}');

    return (success ?? 0) > 0;
  }
}
