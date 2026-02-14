import '../repositories/transaction_repository.dart';

class DeleteTransaction {
  final TransactionRepository repository;

  DeleteTransaction(this.repository);

  Future<void> call(int id) async {
    if (id <= 0) {
      throw ArgumentError('Invalid transaction id');
    }

    await repository.deleteTransaction(id);
  }
}
