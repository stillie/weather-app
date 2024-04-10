import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/home/forcase_list_item.dart';
import 'package:weatherapp/home/forecast_weather_repository.dart';

class ForecastWeatherView extends StatelessWidget {
  const ForecastWeatherView({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Consumer<ForecastWeatherRepository>(
      builder: (
        BuildContext context,
        ForecastWeatherRepository repo,
        Widget? child,
      ) {
        if (repo.forcastWeather == null) {
          return const CircularProgressIndicator();
        }

        return Container(
          decoration: const BoxDecoration(color: Colors.blue),
          child: ListView.builder(
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            itemCount: repo.filteredItems.length,
            itemBuilder: (context, index) {
              return ForcaseListItem(
                weatherItem: repo.filteredItems[index],
              );
            },
          ),
        );
      },
    );
  }
}
