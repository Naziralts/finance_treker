import '../entities/transaction_entity.dart';
import '../repositories/transaction_repository.dart';

class AddTransaction {
  final TransactionRepository repository;

  AddTransaction(this.repository);

 
  Future<void> call(TransactionEntity transaction) async {
   
    if (transaction.title.trim().isEmpty) {
      throw Exception('Transaction title cannot be empty');
    }

    if (transaction.amount <= 0) {
      throw Exception('Amount must be greater than zero');
    }

    await repository.addTransaction(transaction);
  }
}
