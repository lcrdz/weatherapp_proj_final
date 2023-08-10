import 'package:flutter/material.dart';
import 'package:weather_app_v2_proj/extensions.dart';
import 'package:weather_app_v2_proj/model/location_model.dart';
import 'package:weather_app_v2_proj/model/weather_model.dart';

Widget currentScreen(Location location, Weather weather) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    mainAxisSize: MainAxisSize.max,
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Text(
          location.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Row(
        children: [
          if (location.region.isNotEmpty) Text("${location.region},"),
          Text(location.country),
        ],
      ),
      Text(
        weather.temperature.toTemperatureFormat(),
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.orange,
          fontSize: 24,
        ),
      ),
    ],
  );
}

    // var curren_locationtlyScreen = tabScreen([
    //   _location.name,
    //   _location.region,
    //   .country,
    //   _weather.temperature.toTemperatureFormat(),
    //   _weather.weathercode.currentWeather(),
    //   _weather.windSpeed.toWindSpeedFormat(),
    // ]);