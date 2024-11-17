import 'package:amazon_clone/features/admin/model/sales.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class GraphChart extends StatelessWidget {
  final List<Sales> seriesList;

  const GraphChart({Key? key, required this.seriesList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: seriesList.map((e) => e.earning).reduce((a, b) => a > b ? a : b) +
            10, // Максимальное значение на оси Y с небольшим отступом
        barGroups: seriesList
            .asMap()
            .entries
            .map(
              (entry) => BarChartGroupData(
                x: entry.key,
                barRods: [
                  BarChartRodData(
                    toY: entry.value.earning.toDouble(),
                    color: Colors.blue,
                    width: 20,
                  ),
                ],
                showingTooltipIndicators: [0],
              ),
            )
            .toList(),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, _) => Text(
                value.toInt().toString(),
                style: const TextStyle(fontSize: 10),
              ),
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                int index = value.toInt();
                if (index >= 0 && index < seriesList.length) {
                  return SideTitleWidget(
                    axisSide: meta.axisSide,
                    child: Text(
                      seriesList[index].label,
                      style: const TextStyle(fontSize: 10),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        gridData: FlGridData(show: true),
      ),
    );
  }
}
