class AppException implements Exception {
  final String message;

  AppException(this.message);

  @override
  String toString() => message;
}

class Failure {
  final String message;

  Failure(this.message);

  @override
  String toString() => message;
}

Failure handleError(Exception exception) {
  if (exception is AppException) {
    return Failure(exception.message);
  }
  return Failure('Unexpected error occurred: ${exception.toString()}');
}
