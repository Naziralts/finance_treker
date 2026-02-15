import 'package:equatable/equatable.dart';
import '../../domain/entities/transaction_entity.dart';

class DashboardState extends Equatable {
  final List<TransactionEntity> transactions;
  final bool isLoading;
  final String? error;

  const DashboardState({
    this.transactions = const [],
    this.isLoading = false,
    this.error,
  });

  DashboardState copyWith({
    List<TransactionEntity>? transactions,
    bool? isLoading,
    String? error,
  }) {
    return DashboardState(
      transactions: transactions ?? this.transactions,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }


  double get totalBalance {
    return transactions.fold(
      0,
      (sum, t) =>
          t.isIncome ? sum + t.amount : sum - t.amount,
    );
  }


  double get totalIncome {
    return transactions
        .where((t) => t.isIncome)
        .fold(0, (sum, t) => sum + t.amount);
  }


  double get totalExpense {
    return transactions
        .where((t) => !t.isIncome)
        .fold(0, (sum, t) => sum + t.amount);
  }

  @override
  List<Object?> get props =>
      [transactions, isLoading, error];
}
