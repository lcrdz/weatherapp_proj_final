import 'package:flutter/material.dart';
import 'package:weather_app_v2_proj/model/location_model.dart';

List<Widget> locationHeader(Location location) {
  return [
    const SizedBox(height: 48),
    Text(
      location.name,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (location.region.isNotEmpty) Text("${location.region},"),
        Text(location.country),
      ],
    ),
    const SizedBox(height: 32),
  ];
}
