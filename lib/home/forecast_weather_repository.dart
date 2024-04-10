import 'package:flutter/material.dart';
import 'package:weatherapp/networking/api_client.dart';
import 'package:weatherapp/networking/exceptions/weather_request_failure.dart';
import 'package:weatherapp/networking/models/forcast.dart';

class ForecastWeatherRepository extends ChangeNotifier {
  final ApiClient _apiClient;

  Forecast? forcastWeather;
  final List<ForecastItem> filteredItems = [];

  ForecastWeatherRepository({required ApiClient apiClient})
      : _apiClient = apiClient;

  void getWeatherForcast(
    double lat,
    double lon,
  ) async {
    try {
      forcastWeather = await _apiClient.fetchForcastWeather(
        lat,
        lon,
        useDummyData: true,
      );
      if (forcastWeather == null) throw WeatherRequestFailure();
      for (var i = 0; i < forcastWeather!.forecastItem.length; i += 8) {
        filteredItems.add(forcastWeather!.forecastItem[i]);
      }
    } catch (error) {
      throw WeatherRequestFailure();
    } finally {
      notifyListeners();
    }
  }
}
