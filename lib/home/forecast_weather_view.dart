import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/home/forcase_list_item.dart';
import 'package:weatherapp/home/weather_repository.dart';
import 'package:weatherapp/networking/models/forcast.dart';

class ForecastWeatherView extends StatelessWidget {
  const ForecastWeatherView({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherRepository>(
      builder: (BuildContext context, WeatherRepository value, Widget? child) {
        if (value.forcastWeather == null) {
          return const CircularProgressIndicator();
        }
        final Forecast weather = value.forcastWeather!;
        // return Column(
        //   crossAxisAlignment: CrossAxisAlignment.stretch,
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   mainAxisSize: MainAxisSize.min,
        //   children: [
        //     ...weather.forecastItem.map(
        //       (item) => ForcaseListItem(
        //         weatherItem: item,
        //       ),
        //     ),
        //   ],
        // );
        final List<ForecastItem> filteredItems = [];
        for (var i = 0; i < weather.forecastItem.length; i+=8) {
          filteredItems.add(weather.forecastItem[i]);
        }
        return Container(
          decoration: BoxDecoration(color: Colors.blue),
          child: ListView.builder(
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            itemCount: filteredItems.length,
            itemBuilder: (context, index) {
              return ForcaseListItem(
                weatherItem: filteredItems[index],
              );
            },
          ),
        );
      },
    );
  }
}
