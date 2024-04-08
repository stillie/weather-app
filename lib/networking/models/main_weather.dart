class WeatherMain {
  WeatherMain({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
    required this.seaLevel,
    required this.grndLevel,
  });
  late final double temp;
  late final double feelsLike;
  late final double tempMin;
  late final double tempMax;
  late final int pressure;
  late final int humidity;
  late final int seaLevel;
  late final int grndLevel;

  WeatherMain.fromJson(Map<String, dynamic> json) {
    temp = double.parse(json['temp'].toString());
    feelsLike = double.parse(json['feels_like'].toString());
    tempMin = double.parse(json['temp_min'].toString());
    tempMax = double.parse(json['temp_max'].toString());
    pressure = json['pressure'];
    humidity = json['humidity'];
    seaLevel = json['sea_level'];
    grndLevel = json['grnd_level'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['temp'] = temp;
    data['feels_like'] = feelsLike;
    data['temp_min'] = tempMin;
    data['temp_max'] = tempMax;
    data['pressure'] = pressure;
    data['humidity'] = humidity;
    data['sea_level'] = seaLevel;
    data['grnd_level'] = grndLevel;
    return data;
  }
}
