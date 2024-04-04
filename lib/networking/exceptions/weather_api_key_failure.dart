import 'package:weatherapp/networking/exceptions/base_exception.dart';

/// Exception thrown when weather API Key is invalid
class WeatherApiKeyFailure extends BaseException {
  WeatherApiKeyFailure()
      : super(displayMessageParam: "API Key is invalid or empty");
}
