import 'package:flutter/material.dart';
import 'package:weatherapp/home/current_temp_range_view.dart';
import 'package:weatherapp/networking/models/main_weather.dart';
import 'package:weatherapp/utils.dart';

class CurrentWeatherView extends StatelessWidget {
  final WeatherType weatherType;

  final WeatherMain weatherMain;

  const CurrentWeatherView({
    super.key,
    required this.weatherType,
    required this.weatherMain,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Utils.getColourFromWeatherType(
        weatherType,
      ),
      child: Column(
        children: [
          Stack(
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
                    Utils.renderTemperature(weatherMain.temp),
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
          CurrentTempRangeView(
            weather: weatherMain,
            weatherType: weatherType,
          )
        ],
      ),
    );
  }
}
