import 'package:finance_treker/core/constants/app_strings.dart';
import 'package:finance_treker/core/constants/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../bloc/dashboard_bloc.dart';
import '../bloc/dashboard_event.dart';
import '../bloc/dashboard_state.dart';

import '../widgets/balance_card.dart';
import '../widgets/transaction_list.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() =>
      _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

  @override
  void initState() {
    super.initState();
    context.read<DashboardBloc>().add(
          const LoadTransactions(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {

        if (state.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state.error != null) {
          return Center(
            child: Text(
              state.error!,
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [

              /// 🔹 Header
              Text(
                AppStrings.dashboard,
                style:
                    AppTextStyles.headlineLarge(context),
              ),

              const SizedBox(height: 20),

              /// 🔹 Balance Card
              BalanceCard(
                totalBalance: state.totalBalance,
                totalIncome: state.totalIncome,
                totalExpense: state.totalExpense,
              ),

              const SizedBox(height: 30),

              /// 🔹 Recent Transactions
              Text(
                AppStrings.recentTransactions,
                style:
                    AppTextStyles.headlineMedium(context),
              ),

              const SizedBox(height: 12),

              Expanded(
                child: state.transactions.isEmpty
                    ? Center(
                        child: Text(
                          AppStrings.noTransactions,
                          style:
                              AppTextStyles.bodyMedium(
                                  context),
                        ),
                      )
                    : TransactionList(
                        transactions:
                            state.transactions,
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
