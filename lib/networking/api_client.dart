import 'dart:convert';

import 'package:flutter/foundation.dart';
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

  Future<WeatherModel> fetchCurrentWeather(double lat, double lon,
      {String units = "metric"}) async {
    if (kDebugMode) {
      return WeatherModel.fromJson(jsonDecode(dummyJson));
    }
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
        'units': units,
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

const String dummyJson = '''{
    "coord": {
        "lon": 17.91,
        "lat": -32.8874
    },
    "weather": [
        {
            "id": 802,
            "main": "Clouds",
            "description": "scattered clouds",
            "icon": "03n"
        }
    ],
    "base": "stations",
    "main": {
        "temp": 14.86,
        "feels_like": 16.69,
        "temp_min": 16.86,
        "temp_max": 16.86,
        "pressure": 1015,
        "humidity": 80,
        "sea_level": 1015,
        "grnd_level": 1009
    },
    "visibility": 10000,
    "wind": {
        "speed": 10.28,
        "deg": 182,
        "gust": 15.53
    },
    "clouds": {
        "all": 33
    },
    "dt": 1712251799,
    "sys": {
        "type": 1,
        "id": 1943,
        "country": "ZA",
        "sunrise": 1712206935,
        "sunset": 1712248793
    },
    "timezone": 7200,
    "id": 3361934,
    "name": "Saldanha",
    "cod": 200
}''';
