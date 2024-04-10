import 'package:flutter/material.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:weatherapp/constants.dart';
import 'package:weatherapp/home/current_temp_range_view.dart';
import 'package:weatherapp/home/current_weather_view.dart';
import 'package:weatherapp/home/forcase_list_item.dart';
import 'package:weatherapp/networking/models/forcast.dart';
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

  testGoldens('Current weather widgets look correct combined', (tester) async {
    final builder = GoldenBuilder.column(
      wrap: (widget) => widget,
    )
      ..addScenario(
          'Cloudy',
          Column(
            children: [
              const CurrentWeatherView(
                weatherType: WeatherType.cloudy,
                temperature: 14.95,
              ),
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
            ],
          ))
      ..addScenario(
        'Sunny',
        Column(
          children: [
            const CurrentWeatherView(
              weatherType: WeatherType.sunny,
              temperature: 14.95,
            ),
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
          ],
        ),
      )
      ..addScenario(
        'Rainy',
        Column(
          children: [
            const CurrentWeatherView(
              weatherType: WeatherType.rainy,
              temperature: 14.95,
            ),
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
          ],
        ),
      );
    await tester.pumpWidgetBuilder(
      builder.build(),
      surfaceSize: const Size(
        400,
        1300,
      ),
    );

    await screenMatchesGolden(
        tester, 'current_temp_widgets_look_correct_together');
  });

  testGoldens('Forcast list widgets look correct', (tester) async {
    final builder = GoldenBuilder.column(
      wrap: (widget) => Container(
          decoration: const BoxDecoration(
            color: Colors.black,
          ),
          child: SizedBox(height: 50, width: 300, child: widget)),
    )
      ..addScenario(
        'Clear',
        ForcaseListItem(
            weatherItem: ForecastItem(
                dt: 1712750400,
                main: Main(
                  temp: 16.13,
                  feelsLike: 15.91,
                  tempMin: 16.13,
                  tempMax: 16.36,
                  pressure: 1022,
                  seaLevel: 1022,
                  grndLevel: 1021,
                  humidity: 81,
                ),
                weather: [
                  Weather(
                      id: 800,
                      main: "Clear",
                      description: "clear",
                      icon: "03d")
                ],
                clouds: Clouds(all: 38),
                wind: Wind(speed: 10.86, deg: 149, gust: 15.77),
                visibility: 10000,
                dtTxt: "2024-04-10 12:00:00")),
      )
      ..addScenario(
        'Rain',
        ForcaseListItem(
          weatherItem: ForecastItem(
              dt: 1712750400,
              main: Main(
                temp: 16.13,
                feelsLike: 15.91,
                tempMin: 16.13,
                tempMax: 16.36,
                pressure: 1022,
                seaLevel: 1022,
                grndLevel: 1021,
                humidity: 81,
              ),
              weather: [
                Weather(
                    id: 300,
                    main: "Rain",
                    description: "rain",
                    icon: "03d")
              ],
              clouds: Clouds(all: 38),
              wind: Wind(speed: 10.86, deg: 149, gust: 15.77),
              visibility: 10000,
              dtTxt: "2024-04-10 12:00:00"),
        ),
      )
      ..addScenario(
        'Cloudy',
        ForcaseListItem(
          weatherItem: ForecastItem(
              dt: 1712750400,
              main: Main(
                temp: 16.13,
                feelsLike: 15.91,
                tempMin: 16.13,
                tempMax: 16.36,
                pressure: 1022,
                seaLevel: 1022,
                grndLevel: 1021,
                humidity: 81,
              ),
              weather: [
                Weather(
                    id: 802,
                    main: "Clouds",
                    description: "scattered clouds",
                    icon: "03d")
              ],
              clouds: Clouds(all: 38),
              wind: Wind(speed: 10.86, deg: 149, gust: 15.77),
              visibility: 10000,
              dtTxt: "2024-04-10 12:00:00"),
        ),
      );
    await tester.pumpWidgetBuilder(
      builder.build(),
      surfaceSize: const Size(
        300,
        320,
      ),
    );

    await screenMatchesGolden(tester, 'forcast_list_item');
  });
}