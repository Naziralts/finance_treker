import 'package:finance_treker/core/database/database_helper.dart';
import 'package:sqflite/sqflite.dart';


import '../models/transaction_model.dart';

abstract class TransactionLocalDataSource {

  /// 📥 Получить все транзакции
  Future<List<TransactionModel>> getTransactions();

  /// ➕ Добавить транзакцию (возвращает id)
  Future<int> addTransaction(TransactionModel transaction);

  /// 🗑 Удалить транзакцию
  Future<void> deleteTransaction(int id);

  /// 🔄 Обновить транзакцию
  Future<void> updateTransaction(TransactionModel transaction);

  /// 🧹 Очистить всё
  Future<void> clearTransactions();
}

//////////////////////////////////////////////////////////////////
// IMPLEMENTATION
//////////////////////////////////////////////////////////////////

class TransactionLocalDataSourceImpl
    implements TransactionLocalDataSource {

  final DatabaseHelper databaseHelper;

  TransactionLocalDataSourceImpl(this.databaseHelper);

  static const String _tableName = 'transactions';

  ////////////////////////////////////////////////////////////////
  // 📥 GET
  ////////////////////////////////////////////////////////////////

  @override
  Future<List<TransactionModel>> getTransactions() async {
    final Database db = await databaseHelper.database;

    final result = await db.query(
      _tableName,
      orderBy: 'date DESC',
    );

    return result
        .map((map) => TransactionModel.fromMap(map))
        .toList();
  }

  ////////////////////////////////////////////////////////////////
  // ➕ ADD (ВАЖНО: возвращает id)
  ////////////////////////////////////////////////////////////////

  @override
  Future<int> addTransaction(
      TransactionModel transaction) async {

    final Database db = await databaseHelper.database;

    return await db.insert(
      _tableName,
      transaction.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  ////////////////////////////////////////////////////////////////
  // 🗑 DELETE
  ////////////////////////////////////////////////////////////////

  @override
  Future<void> deleteTransaction(int id) async {
    final Database db = await databaseHelper.database;

    await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  ////////////////////////////////////////////////////////////////
  // 🔄 UPDATE
  ////////////////////////////////////////////////////////////////

  @override
  Future<void> updateTransaction(
      TransactionModel transaction) async {

    final Database db = await databaseHelper.database;

    await db.update(
      _tableName,
      transaction.toMap(),
      where: 'id = ?',
      whereArgs: [transaction.id],
    );
  }

  ////////////////////////////////////////////////////////////////
  // 🧹 CLEAR
  ////////////////////////////////////////////////////////////////

  @override
  Future<void> clearTransactions() async {
    final Database db = await databaseHelper.database;
    await db.delete(_tableName);
  }
}
