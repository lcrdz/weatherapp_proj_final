import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

Widget temperatureChart() {
  return Center(
    child: LineChart(
      LineChartData(
        gridData: const FlGridData(
            show: true, drawHorizontalLine: true, drawVerticalLine: true),
        titlesData: const FlTitlesData(show: true),
        borderData: FlBorderData(show: false),
        minX: 0,
        maxX: 6,
        minY: 0,
        maxY: 6,
        lineBarsData: [
          LineChartBarData(
            spots: [
              const FlSpot(0, 2),
              const FlSpot(2, 4),
              const FlSpot(4, 6),
            ],
            isCurved: true,
            color: Colors.blue,
          ),
        ],
      ),
    ),
  );
}
