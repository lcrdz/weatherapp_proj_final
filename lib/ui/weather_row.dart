import 'package:flutter/material.dart';
import 'package:weather_app_v2_proj/model/daily_weather.model.dart';
import 'package:weather_app_v2_proj/model/weekly_weather.model.dart';
import 'package:weather_app_v2_proj/ui/weather_item.dart';

SingleChildScrollView todayWeatherRow(List<TodayWeatherVO> data) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: data
          .map((item) => weatherItem(
                dateTime: item.time,
                weathetIcon: item.icon,
                currentTemperature: item.temperature,
                windSpeed: item.windSpeed,
              ))
          .toList(),
    ),
  );
}

SingleChildScrollView weeklyWeatherRow(List<WeeklyWeatherVO> data) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: data
          .map((item) => weatherItem(
                dateTime: item.date,
                weathetIcon: item.icon,
                maxTemperature: item.maxTemperature,
                minTemperature: item.minTemperature,
                padding: 8,
              ))
          .toList(),
    ),
  );
}
