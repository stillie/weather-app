class BaseException implements Exception {
  final String displayMessage;
  final String apiMessage;
  BaseException({String? displayMessageParam, String? apiMessageParam})
      : displayMessage = displayMessageParam ?? 'An error occurred requesting the data',
        apiMessage = apiMessageParam ?? '';
}
