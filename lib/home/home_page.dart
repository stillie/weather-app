import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/home/weather_repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("SomeText"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              context.watch<WeatherRepository>().currentWeather?.name ??
                  "Loading",
            ),
          ],
        ),
      ),
    );
  }
}
