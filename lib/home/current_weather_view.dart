import 'package:flutter/material.dart';
import 'package:weatherapp/utils.dart';

class CurrentWeatherView extends StatelessWidget {
  final WeatherType weatherType;

  final double temperature;

  const CurrentWeatherView({
    super.key,
    required this.weatherType,
    required this.temperature,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Utils.getColourFromWeatherType(
        weatherType,
      ),
      child: Stack(
        children: [
          Image(
            fit: BoxFit.cover,
            image: Utils.getBackgroundImage(
              weatherType,
            ),
          ),
          Positioned.fill(
            top: -100,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                Utils.renderTemperature(temperature),
                style: const TextStyle(
                  fontSize: 64,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                weatherType.name.toUpperCase(),
                style: const TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
