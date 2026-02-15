import 'package:equatable/equatable.dart';

class TransactionEntity extends Equatable {
  final int? id;
  final String title;
  final double amount;
  final bool isIncome;
  final DateTime date;
  final String category;

  const TransactionEntity({
    this.id,
    required this.title,
    required this.amount,
    required this.isIncome,
    required this.date,
    required this.category,
  });


  TransactionEntity copyWith({
    int? id,
    String? title,
    double? amount,
    bool? isIncome,
    DateTime? date,
    String? category,
  }) {
    return TransactionEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      isIncome: isIncome ?? this.isIncome,
      date: date ?? this.date,
      category: category ?? this.category,
    );
  }

  @override
  List<Object?> get props =>
      [id, title, amount, isIncome, date, category];
}
