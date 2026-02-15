import 'package:finance_treker/core/constants/app_strings.dart';
import 'package:finance_treker/core/constants/app_text_styles.dart';
import 'package:finance_treker/core/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:finance_treker/core/features/dashboard/presentation/bloc/dashboard_state.dart';
import 'package:finance_treker/core/features/dashboard/presentation/widgets/statistics_chart.dart' show StatisticsChart;
import 'package:finance_treker/core/utils/currency_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {

        if (state.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [

          
              Text(
                AppStrings.statistics,
                style:
                    AppTextStyles.headlineLarge(context),
              ),

              const SizedBox(height: 24),

           
              StatisticsChart(
                data: state!.transactions
                    .take(10)
                    .map((e) => e.amount)
                    .toList(),
              ),

              const SizedBox(height: 30),

              /// 🔹 Summary Cards
              Row(
                children: [
                  Expanded(
                    child: _summaryCard(
                      context,
                      title: AppStrings.income,
                      value: state.totalIncome,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _summaryCard(
                      context,
                      title: AppStrings.expense,
                      value: state.totalExpense,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  ////////////////////////////////////////////////////////////////
  // 📊 Summary Card
  ////////////////////////////////////////////////////////////////

  Widget _summaryCard(
    BuildContext context, {
    required String title,
    required double value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style:
                AppTextStyles.bodyMedium(context),
          ),
          const SizedBox(height: 10),
          Text(
            CurrencyFormatter.format(value),
            style:
                AppTextStyles.headlineSmall(context)
                    .copyWith(color: color),
          ),
        ],
      ),
    );
  }
}
