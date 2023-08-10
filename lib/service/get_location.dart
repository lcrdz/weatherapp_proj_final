import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app_v2_proj/model/location_model.dart';

Future<List<Location>?> fetchLocationData(String search) async {
  String url =
      "https://geocoding-api.open-meteo.com/v1/search?name=$search&count=5&language=pt&format=json";

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body)['results'] as List<dynamic>;
    return Location.fromJsonList(jsonData);
  } else {
    debugPrint('Request failed with status: ${response.statusCode}');
    return null;
  }
}
