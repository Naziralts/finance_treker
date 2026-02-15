import 'package:finance_treker/core/constants/app_colors.dart';
import 'package:finance_treker/core/constants/app_text_styles.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';



class StatisticsChart extends StatelessWidget {
  final List<double> data;

  const StatisticsChart({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return const Center(child: Text("No data"));
    }

    return Container(
      height: 250,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).cardColor,
      ),
      child: LineChart(
        LineChartData(
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: _getInterval(),
          ),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                getTitlesWidget:
                    (value, meta) => Text(
                  value.toInt().toString(),
                  style:
                      AppTextStyles.bodySmall(context),
                ),
              ),
            ),
            bottomTitles: const AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
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
          lineBarsData: [
            LineChartBarData(
              isCurved: true,
              spots: _generateSpots(),
              color: AppColors.primaryStart,
              barWidth: 4,
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [
                    AppColors.primaryStart
                        .withOpacity(0.3),
                    AppColors.primaryEnd
                        .withOpacity(0.05),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              dotData: const FlDotData(
                show: false,
              ),
            ),
          ],
        ),
      ),
    );
  }



  List<FlSpot> _generateSpots() {
    return List.generate(
      data.length,
      (index) => FlSpot(
        index.toDouble(),
        data[index],
      ),
    );
  }



  double _getInterval() {
    final max =
        data.reduce((a, b) => a > b ? a : b);

    return (max / 5).ceilToDouble();
  }
}
