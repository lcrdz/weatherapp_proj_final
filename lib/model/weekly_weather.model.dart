import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app_v2_proj/extensions.dart';
import 'package:weather_app_v2_proj/ui/temperature_chart.dart';

class WeeklyWeather {
  final List<DateTime> time;
  final List<int> weatherCode;
  final List<double> maxTemperature;
  final List<double> minTemperature;

  WeeklyWeather({
    this.time = const [],
    this.weatherCode = const [],
    this.maxTemperature = const [],
    this.minTemperature = const [],
  });

  factory WeeklyWeather.fromJson(Map<String, dynamic> json) {
    return WeeklyWeather(
      time: (json['time'] as List<dynamic>).toDateTime(),
      weatherCode: (json['weathercode'] as List<dynamic>).toInt(),
      maxTemperature: (json['temperature_2m_max'] as List<dynamic>).toDouble(),
      minTemperature: (json['temperature_2m_min'] as List<dynamic>).toDouble(),
    );
  }
}

class WeeklyWeatherVO {
  String date;
  IconData icon;
  String maxTemperature;
  String minTemperature;

  WeeklyWeatherVO({
    required this.date,
    required this.icon,
    required this.maxTemperature,
    required this.minTemperature,
  });
}

extension Converter on WeeklyWeather {
  List<WeeklyWeatherVO> toVO() {
    return time
        .mapIndexed((i, element) => WeeklyWeatherVO(
              date: DateFormat('dd/MM').format(time[i]),
              icon: weatherCode[i].currentWeatherIcon(),
              maxTemperature: maxTemperature[i].toTemperatureFormat(),
              minTemperature: minTemperature[i].toTemperatureFormat(),
            ))
        .toList();
  }

  List<WeatherChartData> toMaxChartData() {
    return maxTemperature
        .mapIndexed((index, element) => WeatherChartData(element, time[index]))
        .toList();
  }

  List<WeatherChartData> toMinChartData() {
    return minTemperature
        .mapIndexed((index, element) => WeatherChartData(element, time[index]))
        .toList();
  }
}
