import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/home/current_temp_range_view.dart';
import 'package:weatherapp/home/current_weather_view.dart';
import 'package:weatherapp/home/forecast_weather_view.dart';
import 'package:weatherapp/home/weather_repository.dart';
import 'package:weatherapp/networking/models/main_weather.dart';
import 'package:weatherapp/networking/models/weather_model.dart';
import 'package:weatherapp/utils.dart';

class HomePage extends StatelessWidget {
  final WeatherRepository weatherRepository;

  const HomePage({super.key, required this.weatherRepository});
  // final WeatherMain weatherMain = WeatherMain(
  //   temp: 14.95,
  //   feelsLike: 14.88,
  //   tempMin: 14.95,
  //   tempMax: 14.95,
  //   pressure: 1014,
  //   humidity: 91,
  //   seaLevel: 1014,
  //   grndLevel: 1007,
  // );

  // final Weather weather = Weather(
  //   id: 800,
  //   main: "Clouds",
  //   description: "overcast clouds",
  //   icon: "04n",
  // );
  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherRepository>(
      builder: (BuildContext context, WeatherRepository repo, Widget? child) {
        if (repo.currentWeather == null) {
          return const CircularProgressIndicator();
        }
        final WeatherModel weatherModel = repo.currentWeather!;

        final WeatherType weatherType =
            Utils.getWeatherType(weatherModel.weather.first);
        final WeatherMain weatherMain = weatherModel.main;
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Utils.getColourFromWeatherType(weatherType),
          ),
          extendBodyBehindAppBar: false,
          body: Column(
            children: [
              CurrentWeatherView(
                weatherType: weatherType,
                temperature: weatherMain.temp,
              ),
              CurrentTempRangeView(
                weather: weatherMain,
                weatherType: weatherType,
              ),
              const ForecastWeatherView(),
            ],
          ),
        );
      },
    );
  }
}

double getScreenHeightWithoutAppBar(BuildContext context) {
  return MediaQuery.of(context).size.height -
      (MediaQuery.of(context).padding.top + kToolbarHeight);
}
