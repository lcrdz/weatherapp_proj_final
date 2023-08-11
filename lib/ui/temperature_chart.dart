import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:weather_app_v2_proj/model/daily_weather.model.dart';
import 'package:weather_app_v2_proj/model/weekly_weather.model.dart';

Widget todayChart(DailyWeather dailyWeather) {
  return SfCartesianChart(
    title: ChartTitle(text: "Today temperatures"),
    series: <ChartSeries>[
      LineSeries<WeatherChartData, DateTime>(
        dataSource: dailyWeather.toChartData(),
        xValueMapper: (WeatherChartData data, _) => data.dateTime,
        yValueMapper: (WeatherChartData data, _) => data.temperature,
        markerSettings: const MarkerSettings(
          isVisible: true,
          color: Colors.orange,
        ),
        dataLabelSettings: const DataLabelSettings(
            isVisible: true, labelAlignment: ChartDataLabelAlignment.auto),
      ),
    ],
    primaryXAxis: DateTimeAxis(
      dateFormat: DateFormat.Hm(),
      intervalType: DateTimeIntervalType.hours,
    ),
    primaryYAxis: NumericAxis(
      labelFormat: '{value}°C',
      numberFormat: NumberFormat.decimalPatternDigits(
        decimalDigits: 1,
      ),
    ),
  );
}

Widget weeklyChart(WeeklyWeather weeklyWeather) {
  return SfCartesianChart(
    title: ChartTitle(text: "Weekly temperatures"),
    legend: const Legend(
      isVisible: true,
      position: LegendPosition.bottom,
    ),
    series: <ChartSeries>[
      LineSeries<WeatherChartData, DateTime>(
          name: 'Max temperatures',
          dataSource: weeklyWeather.toMaxChartData(),
          xValueMapper: (WeatherChartData data, _) => data.dateTime,
          yValueMapper: (WeatherChartData data, _) => data.temperature,
          markerSettings: const MarkerSettings(
            isVisible: true,
            color: Colors.white,
          ),
          dataLabelSettings: const DataLabelSettings(
            isVisible: true,
            labelAlignment: ChartDataLabelAlignment.auto,
          ),
          color: Colors.red),
      LineSeries<WeatherChartData, DateTime>(
          name: 'Min temperatures',
          dataSource: weeklyWeather.toMinChartData(),
          xValueMapper: (WeatherChartData data, _) => data.dateTime,
          yValueMapper: (WeatherChartData data, _) => data.temperature,
          markerSettings: const MarkerSettings(
            isVisible: true,
            color: Colors.white,
          ),
          dataLabelSettings: const DataLabelSettings(
            isVisible: true,
            labelAlignment: ChartDataLabelAlignment.auto,
          ),
          color: Colors.blue),
    ],
    primaryXAxis: DateTimeAxis(
      dateFormat: DateFormat('dd/MM'),
      intervalType: DateTimeIntervalType.days,
    ),
    primaryYAxis: NumericAxis(
      labelFormat: '{value}°C',
      numberFormat: NumberFormat.decimalPatternDigits(
        decimalDigits: 1,
      ),
    ),
  );
}

class WeatherChartData {
  final double temperature;
  final DateTime dateTime;

  WeatherChartData(this.temperature, this.dateTime);
}
