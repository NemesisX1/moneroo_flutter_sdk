/// Base class to handle exception from the Moneroo API
class MonerooException implements Exception {
  ///
  MonerooException({
    this.errors,
    this.message,
    this.code,
  });

  ///
  late dynamic errors;

  ///
  late String? message;

  ///
  late int? code;

  ///
  Map<String, dynamic> toJson() => {
        'errors': errors,
        'message': message,
        'code': code,
      };
}

/// This exception is thrown when the request had issues joining the server
class ServiceUnavailableException extends MonerooException {
  ///
  ServiceUnavailableException({
    super.errors,
    super.message,
    super.code,
  });
}
