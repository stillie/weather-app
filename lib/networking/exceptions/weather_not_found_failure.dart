import 'package:weatherapp/networking/exceptions/base_exception.dart';

/// Exception thrown when weather for provided lat lon is not found.
class WeatherNotFoundFailure extends BaseException{
  WeatherNotFoundFailure({String? humanReadibleMessage, String? apiMessage})
      : super(
          displayMessageParam: humanReadibleMessage ?? "Weather not found for the provided location",
          apiMessageParam: apiMessage,
        );
}
