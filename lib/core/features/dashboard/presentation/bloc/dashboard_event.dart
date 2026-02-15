import 'package:equatable/equatable.dart';
import '../../domain/entities/transaction_entity.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object?> get props => [];
}


class LoadTransactions extends DashboardEvent {
  const LoadTransactions();
}



class AddTransactionEvent extends DashboardEvent {
  final TransactionEntity transaction;

  const AddTransactionEvent(this.transaction);

  @override
  List<Object?> get props => [transaction];
}



class DeleteTransactionEvent extends DashboardEvent {
  final int id;

  const DeleteTransactionEvent(this.id);

  @override
  List<Object?> get props => [id];
}



class UpdateTransactionEvent extends DashboardEvent {
  final TransactionEntity transaction;

  const UpdateTransactionEvent(this.transaction);

  @override
  List<Object?> get props => [transaction];
}


class FilterByCategoryEvent extends DashboardEvent {
  final String category;

  const FilterByCategoryEvent(this.category);

  @override
  List<Object?> get props => [category];
}
