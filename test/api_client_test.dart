import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:weatherapp/environment/env.dart';
import 'package:weatherapp/networking/api_client.dart';
import 'package:weatherapp/networking/exceptions/weather_request_failure.dart';
import 'package:weatherapp/networking/models/weather_model.dart';

import 'test_constants.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

class FakeUri extends Fake implements Uri {}

void main() {
  const String baseWeather = 'api.openweathermap.org';
  const lat = -32.88741808072528;
  const lon = 17.90999181598229;

  late http.Client httpClient;
  late ApiClient apiClient;

  setUpAll(() {
    registerFallbackValue(FakeUri());
  });

  setUp(() {
    httpClient = MockHttpClient();
    apiClient = ApiClient(httpClient: httpClient);
  });

  group("Current Weather", () {
    test(
        "Given a Valid ApiClient, When ApiClient is called, Then validate it was called 1 time only",
        () async {
      final response = MockResponse();
      when(() => response.statusCode).thenReturn(200);
      when(() => response.body).thenReturn(validGetCurrentWeatherResponse);
      when(() => httpClient.get(any())).thenAnswer((_) async => response);

      try {
        await apiClient.fetchCurrentWeather(lat, lon);
      } catch (_) {}

      verify(
        () => httpClient.get(
          Uri.https(
            baseWeather,
            'data/2.5/weather',
            {
              'lat': '$lat',
              'lon': '$lon',
              'appid': Env.WEATHER,
              'units': "metric"
            },
          ),
        ),
      ).called(1);
    });

    test(
        "Given a Valid ApiClient, Lat, Lon and API Key, When fetchCurrentWeather is called, then return a valid response",
        () async {
      final response = MockResponse();
      when(() => response.statusCode).thenReturn(200);
      when(() => response.body).thenReturn(validGetCurrentWeatherResponse);
      when(() => httpClient.get(any())).thenAnswer((_) async => response);

      final actualResponse = await apiClient.fetchCurrentWeather(lat, lon);
      expect(
        actualResponse,
        isA<WeatherModel>()
            .having((w) => w.main.feelsLike, 'Weather.main.feelsLike', 16.69)
            .having((w) => w.name, 'Name', 'Saldanha'),
      );
    });

    test(
        "Given a Valid ApiClient, Lat, Lon, When API Key is invalid, then return a valid response",
        () async {
      final response = MockResponse();
      when(() => response.statusCode).thenReturn(200);
      when(() => response.body).thenReturn(validGetCurrentWeatherResponse);
      when(() => httpClient.get(any())).thenAnswer((_) async => response);

      final actualResponse = await apiClient.fetchCurrentWeather(lat, lon);
      expect(
        actualResponse,
        isA<WeatherModel>()
            .having((w) => w.main.feelsLike, 'Weather.main.feelsLike', 16.69)
            .having((w) => w.name, 'Name', 'Saldanha'),
      );
    });

    test(
        "Given a Valid ApiClient, ApiKey, When Lat and/or Lon is invalid, then return a valid error response",
        () async {
      final response = MockResponse();
      when(() => response.statusCode).thenReturn(400);
      when(() => response.body).thenReturn(weatherErrorResponse);
      when(() => httpClient.get(any())).thenAnswer((_) async => response);
      try {
        await apiClient.fetchCurrentWeather(lat, lon);
      } catch (error) {
        expect(
          error,
          isA<WeatherRequestFailure>()
              .having((e) => e.displayMessage, 'Error Display Message',
                  "An error occurred requesting the weather data")
              .having((e) => e.apiMessage, 'Api Message', 'Nothing to geocode'),
        );
      }
    });
  });
}
