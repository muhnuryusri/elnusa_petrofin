class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException({required this.message, this.statusCode});

  @override
  String toString() => message;
}

class BadRequestException extends ApiException {
  BadRequestException({required super.message}) : super(statusCode: 400);
}

class NotFoundException extends ApiException {
  NotFoundException({required super.message}) : super(statusCode: 404);
}

class ServerException extends ApiException {
  ServerException({required super.message}) : super(statusCode: 500);
}