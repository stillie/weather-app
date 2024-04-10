import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/home/current_weather_repository.dart';
import 'package:weatherapp/home/current_weather_view.dart';
import 'package:weatherapp/home/forecast_weather_view.dart';
import 'package:weatherapp/networking/models/main_weather.dart';
import 'package:weatherapp/networking/models/weather_model.dart';
import 'package:weatherapp/utils.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherRepository>(
      builder: (BuildContext context, WeatherRepository repo, Widget? child) {
        if (repo.currentWeather == null) {
          return renderLoadingWidget("Retrieving Weather");
        }
        final WeatherModel weatherModel = repo.currentWeather!;

        final WeatherType weatherType =
            Utils.getWeatherType(weatherModel.weather.first.id);
        final WeatherMain weatherMain = weatherModel.main;

        return renderWidget(
          weatherType: weatherType,
          weatherMain: weatherMain,
        );
      },
    );
  }

  Widget renderLoadingWidget(String displayText) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          children: [
            Text(displayText),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }

  Widget renderWidget(
      {required WeatherType weatherType, required WeatherMain weatherMain}) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Utils.getColourFromWeatherType(weatherType),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CurrentWeatherView(
              weatherType: weatherType,
              weatherMain: weatherMain,
            ),
            const ForecastWeatherView(),
          ],
        ),
      ),
    );
  }
}
