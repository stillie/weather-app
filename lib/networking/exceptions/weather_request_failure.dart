import 'package:weatherapp/networking/exceptions/base_exception.dart';

/// Exception thrown when a get Weather request has failed
class WeatherRequestFailure extends BaseException {
  WeatherRequestFailure({String? humanReadibleMessage, String? apiMessage})
      : super(
          displayMessageParam: humanReadibleMessage ?? "An error occurred requesting the weather data",
          apiMessageParam: apiMessage,
        );
}
