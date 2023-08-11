import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app_v2_proj/extensions.dart';

class DailyWeather {
  List<DateTime> time;
  List<double> temperature;
  List<int> weathercode;
  List<double> windspeed;

  DailyWeather({
    this.time = const [],
    this.temperature = const [],
    this.weathercode = const [],
    this.windspeed = const [],
  });

  factory DailyWeather.fromJson(Map<String, dynamic> json) {
    return DailyWeather(
      temperature: (json['temperature_2m'] as List<dynamic>).toDouble(),
      time: (json['time'] as List<dynamic>).toDateTime(),
      weathercode: (json['weathercode'] as List<dynamic>).toInt(),
      windspeed: (json['windspeed_10m'] as List<dynamic>).toDouble(),
    );
  }
}

class TodayWeatherVO {
  String time;
  IconData icon;
  String temperature;
  String windSpeed;

  TodayWeatherVO({
    required this.time,
    required this.icon,
    required this.temperature,
    required this.windSpeed,
  });
}

extension Converter on DailyWeather {
  List<TodayWeatherVO> toVO() {
    return time
        .mapIndexed((i, element) => TodayWeatherVO(
              time: DateFormat('HH:mm').format(time[i]),
              icon: weathercode[i].currentWeatherIcon(),
              temperature: temperature[i].toTemperatureFormat(),
              windSpeed: windspeed[i].toWindSpeedFormat(),
            ))
        .toList();
  }
}
