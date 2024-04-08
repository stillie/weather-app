import 'package:weatherapp/networking/models/clouds.dart';
import 'package:weatherapp/networking/models/coord.dart';
import 'package:weatherapp/networking/models/main_weather.dart';
import 'package:weatherapp/networking/models/weather.dart';
import 'package:weatherapp/networking/models/wind.dart';

class WeatherModel {
  WeatherModel({
    required this.coord,
    required this.weather,
    required this.base,
    required this.main,
    required this.visibility,
    required this.wind,
    required this.clouds,
    required this.dt,
    required this.timezone,
    required this.id,
    required this.name,
    required this.cod,
  });
  late final Coord coord;
  late final List<Weather> weather;
  late final String base;
  late final WeatherMain main;
  late final int visibility;
  late final Wind wind;
  late final Clouds clouds;
  late final int dt;
  late final int timezone;
  late final int id;
  late final String name;
  late final int cod;

  WeatherModel.fromJson(Map<String, dynamic> json) {
    coord = Coord.fromJson(json['coord']);
    weather =
        List.from(json['weather']).map((e) => Weather.fromJson(e)).toList();
    base = json['base'];
    main = WeatherMain.fromJson(json['main']);
    visibility = json['visibility'];
    wind = Wind.fromJson(json['wind']);
    clouds = Clouds.fromJson(json['clouds']);
    dt = json['dt'];
    timezone = json['timezone'];
    id = json['id'];
    name = json['name'];
    cod = json['cod'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['coord'] = coord.toJson();
    data['weather'] = weather.map((e) => e.toJson()).toList();
    data['base'] = base;
    data['main'] = main.toJson();
    data['visibility'] = visibility;
    data['wind'] = wind.toJson();
    data['clouds'] = clouds.toJson();
    data['dt'] = dt;
    data['timezone'] = timezone;
    data['id'] = id;
    data['name'] = name;
    data['cod'] = cod;
    return data;
  }
}
