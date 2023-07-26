class ErrorException implements Exception {
  final String message;
  final int? statusCode;
  final Map<String, dynamic>? data;

  ErrorException(this.message, {this.data, this.statusCode});

  @override
  String toString() {
    return message;
  }
}
