import 'package:flutter/material.dart';
import 'package:weatherapp/location/location.dart';
import 'package:weatherapp/networking/api_client.dart';
import 'package:weatherapp/networking/exceptions/weather_request_failure.dart';
import 'package:weatherapp/networking/models/forcast.dart';

class ForecastWeatherRepository extends ChangeNotifier {
  final ApiClient _apiClient;

  Forecast? forcastWeather;
  final List<ForecastItem> filteredItems = [];

  final LocationRepository locationRepo;

  ForecastWeatherRepository(
      {required ApiClient apiClient, required this.locationRepo})
      : _apiClient = apiClient;

  void getWeatherForcast() async {
    try {
      final locationData = await locationRepo.initLocationData();
      if (locationData == null) return;
      forcastWeather = await _apiClient.fetchForcastWeather(
        locationData.latitude ?? 0.0,
        locationData.longitude ?? 0.0,
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
