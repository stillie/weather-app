import 'package:flutter/material.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:weatherapp/constants.dart';
import 'package:weatherapp/home/current_temp_range_view.dart';
import 'package:weatherapp/home/current_weather_view.dart';
import 'package:weatherapp/networking/models/main_weather.dart';
import 'package:weatherapp/utils.dart';

void main() {
  testGoldens('Current Weather types should look correct', (tester) async {
    final builder = GoldenBuilder.grid(columns: 2, widthToHeightRatio: 1)
      ..addScenario(
          'Sunny',
          const CurrentWeatherView(
            weatherType: WeatherType.sunny,
            temperature: 30,
          ))
      ..addScenario(
          'Cloudy',
          const CurrentWeatherView(
            weatherType: WeatherType.cloudy,
            temperature: 20,
          ))
      ..addScenario(
          'Raining',
          const CurrentWeatherView(
            weatherType: WeatherType.rainy,
            temperature: 15,
          ));
    await tester.pumpWidgetBuilder(builder.build(),
        surfaceSize: const Size(800, 800));
    await screenMatchesGolden(tester, 'current_weather_types_grid');
  });

  testGoldens('Temperature Range Items looks correct', (tester) async {
    final builder = GoldenBuilder.grid(
      bgColor: cloudyColour,
      columns: 2,
      widthToHeightRatio: 1,
      wrap: (widget) => Container(
          margin: const EdgeInsets.all(15.0),
          padding: const EdgeInsets.all(3.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
            ),
          ),
          child: widget),
    )
      ..addScenario(
        'Min',
        const TempRangeItem(
          temp: 16,
          temperatureRange: TemperatureRange.min,
        ),
      )
      ..addScenario(
        'Current',
        const TempRangeItem(
          temp: 20,
          temperatureRange: TemperatureRange.current,
        ),
      )
      ..addScenario(
        'Max',
        const TempRangeItem(
          temp: 29,
          temperatureRange: TemperatureRange.max,
        ),
      );
    await tester.pumpWidgetBuilder(builder.build(),
        surfaceSize: const Size(400, 400));
    await screenMatchesGolden(tester, 'temperature_range_item_grid');
  });

  testGoldens('Temperature Range row looks correct', (tester) async {
    final builder = GoldenBuilder.column(
      wrap: (widget) => SizedBox(width: 800, child: widget),
    )
      ..addScenario(
        'Cloudy',
        CurrentTempRangeView(
          weatherType: WeatherType.cloudy,
          weather: WeatherMain(
            temp: 14.95,
            feelsLike: 14.88,
            tempMin: 14.95,
            tempMax: 14.95,
            pressure: 1014,
            humidity: 91,
            seaLevel: 1014,
            grndLevel: 1007,
          ),
        ),
      )
      ..addScenario(
        'Sunny',
        CurrentTempRangeView(
          weatherType: WeatherType.sunny,
          weather: WeatherMain(
            temp: 14.95,
            feelsLike: 14.88,
            tempMin: 14.95,
            tempMax: 14.95,
            pressure: 1014,
            humidity: 91,
            seaLevel: 1014,
            grndLevel: 1007,
          ),
        ),
      )
      ..addScenario(
        'Rainy',
        CurrentTempRangeView(
          weatherType: WeatherType.rainy,
          weather: WeatherMain(
            temp: 14.95,
            feelsLike: 14.88,
            tempMin: 14.95,
            tempMax: 14.95,
            pressure: 1014,
            humidity: 91,
            seaLevel: 1014,
            grndLevel: 1007,
          ),
        ),
      );
    await tester.pumpWidgetBuilder(
      builder.build(),
      surfaceSize: const Size(
        800,
        600,
      ),
    );

    await screenMatchesGolden(tester, 'temperature_range_row');
  });
}
