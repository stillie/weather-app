import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/home/home_page.dart';
import 'package:weatherapp/home/weather_repository.dart';
import 'package:weatherapp/networking/api_client.dart';

void main() {
  final ApiClient apiClient = ApiClient();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<WeatherRepository>(
          create: (context) {
            return WeatherRepository(apiClient: apiClient)
              ..getWeatherForCurrentLocation(
                -32.88741808072528,
                17.90999181598229,
              );
          },
        ),
      ],
      child: const WeatherApp(),
    ),
  );
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    final WeatherRepository repository =
        Provider.of<WeatherRepository>(context);
    return MaterialApp(
      title: 'DVT Weather',
      theme: ThemeData(
        primaryTextTheme: GoogleFonts.robotoTextTheme(),
        textTheme: GoogleFonts.robotoTextTheme(),
        useMaterial3: true,
      ),
      home: HomePage(
        weatherRepository: repository,
      ),
    );
  }
}
