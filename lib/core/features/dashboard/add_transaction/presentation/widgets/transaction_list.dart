import 'package:finance_treker/core/constants/app_colors.dart';
import 'package:finance_treker/core/constants/app_icons.dart';
import 'package:finance_treker/core/constants/app_text_styles.dart';
import 'package:finance_treker/core/features/dashboard/domain/entities/transaction_entity.dart';
import 'package:finance_treker/core/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:finance_treker/core/features/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:finance_treker/core/utils/currency_formatter.dart';
import 'package:finance_treker/core/utils/date_formatter.dart';
import 'package:finance_treker/core/widgets/app_svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class TransactionList extends StatelessWidget {
  final List<TransactionEntity> transactions;

  const TransactionList({
    super.key,
    required this.transactions,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: transactions.length,
      separatorBuilder: (_, __) =>
          const SizedBox(height: 14),
      itemBuilder: (context, index) {
        final transaction = transactions[index];
        return _transactionCard(context, transaction);
      },
    );
  }


  Widget _transactionCard(
    BuildContext context,
    TransactionEntity transaction,
  ) {
    final isIncome = transaction.isIncome;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: AppColors.cardDark,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [

          /// 🔹 Icon
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: (isIncome
                      ? AppColors.income
                      : AppColors.expense)
                  .withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: AppSvgIcon(
              path: isIncome
                  ? AppIcons.income
                  : AppIcons.expense,
              size: 18,
              color: isIncome
                  ? AppColors.income
                  : AppColors.expense,
            ),
          ),

          const SizedBox(width: 16),

          /// 🔹 Title + Date
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.title,
                  style:
                      AppTextStyles.bodyLarge(
                          context),
                ),
                const SizedBox(height: 6),
                Text(
                  DateFormatter.formatShort(
                      transaction.date),
                  style:
                      AppTextStyles.bodySmall(
                          context),
                ),
              ],
            ),
          ),

       
          Column(
            crossAxisAlignment:
                CrossAxisAlignment.end,
            children: [
              Text(
                CurrencyFormatter.formatSigned(
                  transaction.amount,
                ),
                style:
                    AppTextStyles.amount(context)
                        .copyWith(
                  color: isIncome
                      ? AppColors.income
                      : AppColors.expense,
                ),
              ),
              const SizedBox(height: 10),

              if (transaction.id != null)
                GestureDetector(
                  onTap: () {
                    context
                        .read<DashboardBloc>()
                        .add(
                          DeleteTransactionEvent(
                            transaction.id!,
                          ),
                        );
                  },
                  child: const AppSvgIcon(
                    path: AppIcons.trash,
                    size: 16,
                    color: Colors.redAccent,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
