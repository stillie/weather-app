import 'package:flutter/material.dart';
import 'package:weatherapp/constants.dart';
import 'package:weatherapp/networking/models/weather.dart';

enum WeatherType { cloudy, rainy, sunny }

class Utils {
  static AssetImage getBackgroundImage(WeatherType weatherType) {
    switch (weatherType) {
      case WeatherType.cloudy:
        return cloudyBG;
      case WeatherType.rainy:
        return rainyBG;
      case WeatherType.sunny:
        return sunnyBG;
      default:
        return sunnyBG;
    }
  }

  static Color getColourFromWeatherType(WeatherType weatherType) {
    switch (weatherType) {
      case WeatherType.cloudy:
        return cloudyColour;
      case WeatherType.rainy:
        return rainyColour;
      case WeatherType.sunny:
        return sunnyColour;
      default:
        return sunnyColour;
    }
  }

  static String renderTemperature(double temp) => "${temp.floor()}°";

// See https://openweathermap.org/weather-conditions
  static WeatherType getWeatherType(Weather weather) {
    switch (weather.id) {
      case 801:
      case 802:
      case 803:
      case 804:
        return WeatherType.cloudy;
      // Thunderstorms
      case 200:
      case 201:
      case 202:
      case 210:
      case 211:
      case 212:
      case 221:
      case 230:
      case 231:
      case 232:
      // Rainy
      case 500:
      case 501:
      case 502:
      case 503:
      case 504:
      case 511:
      case 520:
      case 521:
      case 522:
      case 531:
      // Drizzle
      case 300:
      case 301:
      case 302:
      case 310:
      case 311:
      case 312:
      case 313:
      case 314:
      case 321:
        return WeatherType.rainy;
      case 800:
      default:
        return WeatherType.sunny;
    }
  }
}

// Extension on Strings
extension StringExtension on String {
  String toCamelCase() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
