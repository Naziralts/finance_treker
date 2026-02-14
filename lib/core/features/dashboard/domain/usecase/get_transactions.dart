import '../entities/transaction_entity.dart';
import '../repositories/transaction_repository.dart';

class GetTransactions {
  final TransactionRepository repository;

  GetTransactions(this.repository);

  Future<List<TransactionEntity>> call() async {
    final transactions = await repository.getTransactions();

    transactions.sort(
      (a, b) => b.date.compareTo(a.date),
    );

    return transactions;
  }
}
