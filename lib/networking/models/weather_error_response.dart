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
    final data = <String, dynamic>{};
    data['cod'] = cod;
    data['message'] = message;
    return data;
  }
}