import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weatherapp/environment/env.dart';
import 'package:weatherapp/networking/exceptions/weather_api_key_failure.dart';
import 'package:weatherapp/networking/exceptions/weather_request_failure.dart';
import 'package:weatherapp/networking/models/forcast.dart';
import 'package:weatherapp/networking/models/weather_error_response.dart';
import 'package:weatherapp/networking/models/weather_model.dart';
import 'package:weatherapp/networking/utils/networking_utils.dart';

enum ApiCallType {
  forecast("forecast"),
  weather("weather");

  final String endpoint;
  const ApiCallType(this.endpoint);
}

class ApiClient {
  final http.Client _httpClient;
  final String _baseWeather = 'api.openweathermap.org';

  ApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  Future<WeatherModel> fetchCurrentWeather(
    double lat,
    double lon, {
    String units = "metric",
    bool useDummyData = false,
  }) async {
    final response = await fetchWeather(
      lat,
      lon,
      ApiCallType.weather,
      units: units,
      useDummyData: useDummyData,
    );
    final weather = WeatherModel.fromJson(response);
    return weather;
  }

  Future<Forecast> fetchForcastWeather(double lat, double lon,
      {String units = "metric",
      bool useDummyData = false,
      int numberOfDays = 7}) async {
    final response = await fetchWeather(lat, lon, ApiCallType.forecast,
        units: units,
        useDummyData: useDummyData,
        extraParams: {"cnt": "$numberOfDays"});
    final forcastWeather = Forecast.fromJson(response);
    return forcastWeather;
  }

  Future<Map<String, dynamic>> fetchWeather(
    double lat,
    double lon,
    ApiCallType apiCallType, {
    String units = "metric",
    bool useDummyData = false,
    Map<String, String>? extraParams,
  }) async {
    if (!NetworkingUtils.apiKeyIsValid()) {
      throw WeatherApiKeyFailure();
    }

    Map<String, String> params = {
      'lat': '$lat',
      'lon': '$lon',
      'appid': Env.WEATHER,
      'units': units,
    };
    // if (extraParams != null) {
    //   params.addAll(extraParams);
    // }
    Uri uri = Uri.https(
      _baseWeather,
      'data/2.5/${apiCallType.endpoint}',
      params,
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

    final responseJson = jsonDecode(response.body) as Map<String, dynamic>;

    return responseJson;
  }
}

const String dummyJson = '''{
    "coord": {
        "lon": 17.91,
        "lat": -32.8874
    },
    "weather": [
        {
            "id": 800,
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
