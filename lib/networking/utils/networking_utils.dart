import 'dart:convert';

import 'package:weatherapp/environment/env.dart';

class NetworkingUtils {
  static bool apiKeyIsValid() => Env.WEATHER.isNotEmpty;

  static bool isCurrentWeatherResponseValid(Map<String, dynamic> json) {
    if (!json.containsKey('id')) return false;
    return true;
  }

  static bool isErrorValid(String body) {
    if (body.isEmpty) return false;
    Map<String, dynamic> json = jsonDecode(body);
    if ((json.containsKey('cod') && json['cod'] != null) &&
        (json.containsKey('message') && json['message'] != null)) {
      return true;
    }
    return false;
  }
}
