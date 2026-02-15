import 'package:finance_treker/core/utils/date_formatter.dart';

import '../../domain/entities/transaction_entity.dart';


class TransactionModel extends TransactionEntity {
  const TransactionModel({
    super.id,
    required super.title,
    required super.amount,
    required super.isIncome,
    required super.date,
    required super.category,
  });

  /// 🔄 Из Map (SQLite → Model)
  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'] as int?,
      title: map['title'] as String,
      amount: (map['amount'] as num).toDouble(),
      isIncome: (map['isIncome'] as int) == 1,
      date: DateFormatter.fromIso(map['date'] as String),
      category: map['category'] as String,
    );
  }

  /// 📦 В Map (Model → SQLite)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'isIncome': isIncome ? 1 : 0,
      'date': DateFormatter.toIso(date),
      'category': category,
    };
  }

  /// 🔁 Из Entity (Domain → Data)
  factory TransactionModel.fromEntity(TransactionEntity entity) {
    return TransactionModel(
      id: entity.id,
      title: entity.title,
      amount: entity.amount,
      isIncome: entity.isIncome,
      date: entity.date,
      category: entity.category,
    );
  }
}
