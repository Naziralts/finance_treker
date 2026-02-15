import '../../domain/entities/transaction_entity.dart';
import '../../domain/repositories/transaction_repository.dart';
import '../datasources/transaction_local_datasource.dart';
import '../models/transaction_model.dart';

class TransactionRepositoryImpl
    implements TransactionRepository {

  final TransactionLocalDataSource localDataSource;

  TransactionRepositoryImpl(this.localDataSource);

  @override
  Future<List<TransactionEntity>> getTransactions() async {
    final models = await localDataSource.getTransactions();
    return models;
  }

  @override
  Future<void> addTransaction(
      TransactionEntity transaction) async {

    final model =
        TransactionModel.fromEntity(transaction);

    await localDataSource.addTransaction(model);
  }

  @override
  Future<void> deleteTransaction(int id) async {
    await localDataSource.deleteTransaction(id);
  }

  @override
  Future<void> updateTransaction(
      TransactionEntity transaction) async {

    final model =
        TransactionModel.fromEntity(transaction);

    await localDataSource.updateTransaction(model);
  }

  @override
  Future<void> clearTransactions() async {
    await localDataSource.clearTransactions();
  }
}
