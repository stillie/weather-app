import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weatherapp/environment/env.dart';
import 'package:weatherapp/networking/exceptions/weather_api_key_failure.dart';
import 'package:weatherapp/networking/exceptions/weather_request_failure.dart';
import 'package:weatherapp/networking/models/weather_error_response.dart';
import 'package:weatherapp/networking/models/weather_model.dart';
import 'package:weatherapp/networking/utils/networking_utils.dart';

class ApiClient {
  final http.Client _httpClient;
  final String _baseWeather = 'api.openweathermap.org';

  ApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  Future<WeatherModel> fetchCurrentWeather(double lat, double lon) async {
    if (!NetworkingUtils.apiKeyIsValid()) {
      throw WeatherApiKeyFailure();
    }
    Uri uri = Uri.https(
      _baseWeather,
      'data/2.5/weather',
      {
        'lat': '$lat',
        'lon': '$lon',
        'appid': Env.WEATHER,
      },
    );
    final response = await _httpClient.get(uri);
    if (response.statusCode != 200) {
      final errorResponseJson =
          jsonDecode(response.body) as Map<String, dynamic>;
      if (NetworkingUtils.isErrorValid(response.body)) {
        WeatherErrorResponse errorResponse =
            WeatherErrorResponse.fromJson(errorResponseJson);
        throw WeatherRequestFailure(apiMessage: errorResponse.message);
      }
      throw WeatherRequestFailure();
    }

    final weatherJson = jsonDecode(response.body) as Map<String, dynamic>;

    if (!NetworkingUtils.isCurrentWeatherResponseValid(weatherJson)) {
      throw WeatherRequestFailure();
    }
    final weather = WeatherModel.fromJson(weatherJson);
    return weather;
  }
}
