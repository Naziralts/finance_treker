import 'package:finance_treker/core/features/dashboard/domain/usecase/add_transaction.dart';
import 'package:finance_treker/core/features/dashboard/domain/usecase/delete_transaction.dart';
import 'package:finance_treker/core/features/dashboard/domain/usecase/get_transactions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



import 'dashboard_event.dart';
import 'dashboard_state.dart';

class DashboardBloc
    extends Bloc<DashboardEvent, DashboardState> {

  final GetTransactions getTransactions;
  final AddTransaction addTransaction;
  final DeleteTransaction deleteTransaction;

  DashboardBloc({
    required this.getTransactions,
    required this.addTransaction,
    required this.deleteTransaction, required Object repository,
  }) : super(const DashboardState()) {

    on<LoadTransactions>(_onLoadTransactions);
    on<AddTransactionEvent>(_onAddTransaction);
    on<DeleteTransactionEvent>(_onDeleteTransaction);
  }

  ////////////////////////////////////////////////////////////////
  // LOAD
  ////////////////////////////////////////////////////////////////

  Future<void> _onLoadTransactions(
    LoadTransactions event,
    Emitter<DashboardState> emit,
  ) async {

    emit(state.copyWith(isLoading: true));

    try {
      final transactions = await getTransactions();

      emit(state.copyWith(
        transactions: transactions,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }

  ////////////////////////////////////////////////////////////////
  // ADD
  ////////////////////////////////////////////////////////////////

  Future<void> _onAddTransaction(
    AddTransactionEvent event,
    Emitter<DashboardState> emit,
  ) async {

    try {
      await addTransaction(event.transaction);

      // 🔥 После добавления просто перезагружаем
      add(const LoadTransactions());

    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  ////////////////////////////////////////////////////////////////
  // DELETE
  ////////////////////////////////////////////////////////////////

  Future<void> _onDeleteTransaction(
    DeleteTransactionEvent event,
    Emitter<DashboardState> emit,
  ) async {

    try {
      await deleteTransaction(event.id);

      add(const LoadTransactions());

    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }
}
