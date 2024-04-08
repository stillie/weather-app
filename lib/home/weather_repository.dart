import 'package:flutter/material.dart';
import 'package:weatherapp/networking/api_client.dart';
import 'package:weatherapp/networking/exceptions/weather_request_failure.dart';
import 'package:weatherapp/networking/models/weather_model.dart';

class WeatherRepository extends ChangeNotifier {
  final ApiClient _apiClient;

  WeatherModel? currentWeather;
  WeatherRepository({required ApiClient apiClient}) : _apiClient = apiClient;

  void getWeatherForCurrentLocation(double lat, double lon) async {
    try {
      currentWeather = await _apiClient.fetchCurrentWeather(lat, lon);
    } catch (error) {
      throw WeatherRequestFailure();
    } finally {
      notifyListeners();
    }
  }
}
