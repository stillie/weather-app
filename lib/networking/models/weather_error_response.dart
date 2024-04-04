class WeatherErrorResponse {
  WeatherErrorResponse({
    required this.cod,
    required this.message,
  });
  late final String cod;
  late final String message;
  
  WeatherErrorResponse.fromJson(Map<String, dynamic> json){
    cod = json['cod'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['cod'] = cod;
    _data['message'] = message;
    return _data;
  }
}