import 'package:flutter/material.dart';

Widget weatherItem(
    {required String dateTime,
    required IconData weathetIcon,
    String? currentTemperature,
    String? minTemperature,
    String? maxTemperature,
    String? windSpeed,
    double padding = 0}) {
  return Padding(
    padding: EdgeInsets.only(right: padding),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 8),
        Text(
          dateTime,
          style: const TextStyle(fontSize: 14),
        ),
        const SizedBox(height: 8),
        Icon(
          weathetIcon,
          color: Colors.orange,
          size: 14,
        ),
        const SizedBox(height: 8),
        if (currentTemperature != null)
          Text(
            currentTemperature,
            style: const TextStyle(
              color: Colors.orange,
              fontSize: 16,
            ),
          ),
        const SizedBox(height: 4),
        if (windSpeed != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.air,
                size: 16,
                color: Colors.blueAccent[700],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  windSpeed,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 8,
                  ),
                ),
              ),
            ],
          ),
        if (maxTemperature != null)
          Text(
            "$maxTemperature max",
            style: const TextStyle(color: Colors.red, fontSize: 10),
          ),
        const SizedBox(height: 4),
        if (minTemperature != null)
          Text(
            "$minTemperature min",
            style: const TextStyle(color: Colors.blue, fontSize: 10),
          )
      ],
    ),
  );
}
