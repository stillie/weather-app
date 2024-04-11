import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/home/current_weather_repository.dart';
import 'package:weatherapp/home/forecast_weather_repository.dart';
import 'package:weatherapp/home/home_page.dart';
import 'package:weatherapp/location/location.dart';
import 'package:weatherapp/networking/api_client.dart';

void main() async {
  final ApiClient apiClient = ApiClient();
  WidgetsFlutterBinding.ensureInitialized();
  final LocationRepository locationRepository = LocationRepository();
  await locationRepository.initLocationData();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<LocationRepository>(
          create: (context) {
            return locationRepository;
          },
        ),
        ChangeNotifierProvider<WeatherRepository>(
          create: (context) {
            WeatherRepository repository = WeatherRepository(
              apiClient: apiClient,
              locationRepo: locationRepository,
            );

            repository.getWeatherForCurrentLocation();
            return repository;
          },
        ),
        ChangeNotifierProvider<ForecastWeatherRepository>(
          create: (context) {
            ForecastWeatherRepository repository = ForecastWeatherRepository(
                apiClient: apiClient, locationRepo: locationRepository);
            repository.getWeatherForcast();
            return repository;
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
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primaryTextTheme: GoogleFonts.robotoTextTheme(),
        textTheme: GoogleFonts.robotoTextTheme(),
        useMaterial3: true,
      ),
      home: Consumer<LocationRepository>(
          builder:
              (BuildContext context, LocationRepository repo, Widget? child) {
            if (repo.hasPermissions) {
              return child ?? const HomePage();
            } else {
              return ErrorPage(repo);
            }
          },
          child: const HomePage()),
    );
  }
}

class ErrorPage extends StatelessWidget {
  const ErrorPage(this.repository, {super.key});
  final LocationRepository repository;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Column(
        children: [
          Text("Please enable Location permssions in System Settings"),
        ],
      ),
    );
  }
}
