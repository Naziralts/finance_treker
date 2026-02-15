import 'package:finance_treker/core/database/database_helper.dart';
import 'package:finance_treker/core/features/dashboard/data/datasources/transaction_local_datasource.dart';
import 'package:finance_treker/core/features/dashboard/data/repositories/transaction_repository_impl.dart';
import 'package:finance_treker/core/features/dashboard/domain/repositories/transaction_repository.dart';
import 'package:finance_treker/core/features/dashboard/domain/usecase/add_transaction.dart';
import 'package:finance_treker/core/features/dashboard/domain/usecase/delete_transaction.dart';
import 'package:finance_treker/core/features/dashboard/domain/usecase/get_transactions.dart';
import 'package:finance_treker/core/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {

  // Database
  sl.registerLazySingleton<DatabaseHelper>(
    () => DatabaseHelper.instance,
  );

  // DataSource
  sl.registerLazySingleton<TransactionLocalDataSource>(
    () => TransactionLocalDataSourceImpl(
      sl<DatabaseHelper>(),
    ),
  );

  // Repository
  sl.registerLazySingleton<TransactionRepository>(
    () => TransactionRepositoryImpl(
      sl<TransactionLocalDataSource>(),
    ),
  );

  // UseCases
  sl.registerLazySingleton<GetTransactions>(
    () => GetTransactions(
      sl<TransactionRepository>(),
    ),
  );

  sl.registerLazySingleton<AddTransaction>(
    () => AddTransaction(
      sl<TransactionRepository>(),
    ),
  );

  sl.registerLazySingleton<DeleteTransaction>(
    () => DeleteTransaction(
      sl<TransactionRepository>(),
    ),
  );

  // Bloc
  sl.registerFactory<DashboardBloc>(
    () => DashboardBloc(
      getTransactions: sl<GetTransactions>(),
      addTransaction: sl<AddTransaction>(),
      deleteTransaction: sl<DeleteTransaction>(),
      repository: sl<TransactionRepository>(),
    ),
  );
}

