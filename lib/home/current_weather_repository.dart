import 'package:flutter/material.dart';
import 'package:weatherapp/location/location.dart';
import 'package:weatherapp/networking/api_client.dart';
import 'package:weatherapp/networking/exceptions/weather_request_failure.dart';
import 'package:weatherapp/networking/models/weather_model.dart';

class WeatherRepository extends ChangeNotifier {
  final ApiClient _apiClient;
  final LocationRepository locationRepo;

  WeatherModel? currentWeather;

  WeatherRepository({required ApiClient apiClient, required this.locationRepo})
      : _apiClient = apiClient;

  void getWeatherForCurrentLocation() async {
    final locationData = await locationRepo.initLocationData();
    print("Calling current whether ${locationData?.latitude} ${locationData?.longitude} ");
    try {
      currentWeather = await _apiClient.fetchCurrentWeather(
        locationData?.latitude ?? 0,
        locationData?.longitude ?? 0,
        useDummyData: true,
      );
    } catch (error) {
      throw WeatherRequestFailure();
    } finally {
      notifyListeners();
    }
  }
}
