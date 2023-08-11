import 'package:flutter/material.dart';
import 'package:weather_app_v2_proj/extensions.dart';
import 'package:weather_app_v2_proj/model/location_model.dart';
import 'package:weather_app_v2_proj/model/weather_model.dart';
import 'package:weather_app_v2_proj/ui/location_header.dart';

Widget currentScreen(Location location, Weather weather) {
  return SingleChildScrollView(
    scrollDirection: Axis.vertical,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        ...locationHeader(location),
        Text(
          weather.temperature.toTemperatureFormat(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.orange,
            fontSize: 32,
          ),
        ),
        const SizedBox(height: 24),
        if (weather.weathercode != invalidInt)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              weather.weathercode.currentWeather(),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        if (weather.weathercode != invalidInt)
          Icon(
            weather.weathercode.currentWeatherIcon(),
            color: Colors.orange,
            size: 48,
          ),
        const SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (weather.windSpeed != invalidDouble)
              Icon(
                Icons.air,
                size: 32,
                color: Colors.blueAccent[700],
              ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                weather.windSpeed.toWindSpeedFormat(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        )
      ],
    ),
  );
}
