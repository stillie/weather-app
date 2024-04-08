import 'package:flutter/material.dart';
import 'package:weatherapp/networking/models/main_weather.dart';
import 'package:weatherapp/utils.dart';

class CurrentTempRangeView extends StatelessWidget {
  final WeatherMain weather;
  final WeatherType weatherType;
  const CurrentTempRangeView({
    super.key,
    required this.weather,
    required this.weatherType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Utils.getColourFromWeatherType(weatherType),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TempRangeItem(
            temp: weather.tempMin,
            temperatureRange: TemperatureRange.min,
          ),
          TempRangeItem(
            temp: weather.temp,
            temperatureRange: TemperatureRange.current,
          ),
          TempRangeItem(
            temp: weather.tempMax,
            temperatureRange: TemperatureRange.max,
          ),
        ],
      ),
    );
  }
}

enum TemperatureRange { min, current, max }

class TempRangeItem extends StatelessWidget {
  final double temp;
  final TemperatureRange temperatureRange;

  const TempRangeItem({
    super.key,
    required this.temp,
    required this.temperatureRange,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            Utils.renderTemperature(temp),
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            temperatureRange.name.toCamelCase(),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
