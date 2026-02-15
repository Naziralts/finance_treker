import 'package:finance_treker/core/constants/app_colors.dart';
import 'package:finance_treker/core/constants/app_text_styles.dart';
import 'package:finance_treker/core/features/dashboard/domain/entities/transaction_entity.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';



class CategoryBarChart extends StatelessWidget {
  final List<TransactionEntity> transactions;

  const CategoryBarChart({
    super.key,
    required this.transactions,
  });

  @override
  Widget build(BuildContext context) {
    final groupedData = _groupByCategory();

    if (groupedData.isEmpty) {
      return const Center(child: Text("No data"));
    }

    return Container(
      height: 280,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).cardColor,
      ),
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: _getMaxY(groupedData),
          barTouchData: BarTouchData(enabled: true),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                getTitlesWidget: (value, meta) {
                  return Text(
                    value.toInt().toString(),
                    style:
                        AppTextStyles.bodySmall(context),
                  );
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  final keys =
                      groupedData.keys.toList();
                  if (index >= keys.length) {
                    return const SizedBox();
                  }

                  return Padding(
                    padding:
                        const EdgeInsets.only(top: 8),
                    child: Text(
                      keys[index],
                      style: AppTextStyles.bodySmall(
                          context),
                    ),
                  );
                },
              ),
            ),
            topTitles: const AxisTitles(
              sideTitles:
                  SideTitles(showTitles: false),
            ),
            rightTitles: const AxisTitles(
              sideTitles:
                  SideTitles(showTitles: false),
            ),
          ),
          borderData: FlBorderData(show: false),
          barGroups: _generateBarGroups(groupedData),
        ),
      ),
    );
  }

  ////////////////////////////////////////////////////////////////
  // 📊 Group by Category (Expenses only)
  ////////////////////////////////////////////////////////////////

  Map<String, double> _groupByCategory() {
    final Map<String, double> data = {};

    for (var t in transactions) {
      if (!t.isIncome) {
        data[t.category] =
            (data[t.category] ?? 0) + t.amount;
      }
    }

    return data;
  }


  List<BarChartGroupData> _generateBarGroups(
      Map<String, double> data) {
    final values = data.values.toList();

    return List.generate(values.length, (index) {
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: values[index],
            width: 18,
            borderRadius:
                BorderRadius.circular(8),
            gradient: const LinearGradient(
              colors: [
                AppColors.primaryStart,
                AppColors.primaryEnd,
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
        ],
      );
    });
  }


  double _getMaxY(Map<String, double> data) {
    final max =
        data.values.reduce((a, b) => a > b ? a : b);
    return max * 1.2;
  }
}
