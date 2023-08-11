import 'package:flutter/material.dart';
import 'package:weather_app_v2_proj/model/daily_weather.model.dart';
import 'package:weather_app_v2_proj/model/location_model.dart';
import 'package:weather_app_v2_proj/ui/location_header.dart';
import 'package:weather_app_v2_proj/ui/temperature_chart.dart';
import 'package:weather_app_v2_proj/ui/weather_row.dart';

Widget todayScreen(Location location, DailyWeather dailyWeather) {
  return SingleChildScrollView(
    scrollDirection: Axis.vertical,
    child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          ...locationHeader(location),
          if (dailyWeather.temperature.isNotEmpty) todayChart(dailyWeather),
          todayWeatherRow(dailyWeather.toVO())
        ]),
  );
}
