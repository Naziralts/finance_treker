import 'package:finance_treker/core/constants/app_colors.dart';
import 'package:finance_treker/core/constants/app_icons.dart';
import 'package:finance_treker/core/constants/app_strings.dart';
import 'package:finance_treker/core/constants/app_text_styles.dart';
import 'package:finance_treker/core/utils/currency_formatter.dart';
import 'package:finance_treker/core/widgets/app_svg_icon.dart';
import 'package:flutter/material.dart';

 

class BalanceCard extends StatelessWidget {
  final double totalBalance;
  final double totalIncome;
  final double totalExpense;

  const BalanceCard({
    super.key,
    required this.totalBalance,
    required this.totalIncome,
    required this.totalExpense,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          colors: [
            AppColors.primaryStart,
            AppColors.primaryEnd,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryStart
                .withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [

          /// 🔹 Total Balance
          Text(
            AppStrings.totalBalance,
            style: AppTextStyles.bodyMedium(context)
                .copyWith(color: Colors.white70),
          ),

          const SizedBox(height: 8),

          Text(
            CurrencyFormatter.format(totalBalance),
            style: AppTextStyles.balance(context)
                .copyWith(
              color: Colors.white,
              fontSize: 34,
            ),
          ),

          const SizedBox(height: 24),

          /// 🔹 Income / Expense Row
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              _incomeWidget(context),
              _expenseWidget(context),
            ],
          ),
        ],
      ),
    );
  }

  ////////////////////////////////////////////////////////////////
  // 💰 Income
  ////////////////////////////////////////////////////////////////

  Widget _incomeWidget(BuildContext context) {
    return Row(
      children: [
        const AppSvgIcon(
          path: AppIcons.income,
          size: 20,
          color: Colors.white,
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.income,
              style:
                  AppTextStyles.bodySmall(context)
                      .copyWith(
                color: Colors.white70,
              ),
            ),
            Text(
              CurrencyFormatter.format(totalIncome),
              style:
                  AppTextStyles.amount(context)
                      .copyWith(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }


  Widget _expenseWidget(BuildContext context) {
    return Row(
      children: [
        const AppSvgIcon(
          path: AppIcons.expense,
          size: 20,
          color: Colors.white,
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.expense,
              style:
                  AppTextStyles.bodySmall(context)
                      .copyWith(
                color: Colors.white70,
              ),
            ),
            Text(
              CurrencyFormatter.format(totalExpense),
              style:
                  AppTextStyles.amount(context)
                      .copyWith(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
