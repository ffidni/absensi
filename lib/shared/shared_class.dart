import 'dart:async';
import 'dart:convert';
import 'package:absensi/shared/shared_methods.dart';
import 'package:absensi/shared/shared_values.dart';
import 'package:dio/dio.dart';

class ErrorException extends DioException {
  final String message;
  final int? statusCode;
  final Map<String, dynamic>? data;

  ErrorException(this.message,
      {this.data, this.statusCode, required super.requestOptions});

  @override
  String toString() {
    return message;
  }
}

class CustomDioInterceptor extends Interceptor {
  @override
  FutureOr<dynamic> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Add the Authorization token to the request header if available
    String? token = await getToken();

    if (token != null) {
      options.headers['Authorization'] = token;
    }

    // options.baseUrl = apiBaseUrl;
    options.connectTimeout = const Duration(seconds: 10);
    super.onRequest(options, handler);
  }

  @override
  FutureOr<dynamic> onError(DioException err, ErrorInterceptorHandler handler) {
    // super.onError(err, handler);
    if (err.response != null && err.response!.statusCode! >= 300) {
      final decodedBody = err.response!.data;
      String message = decodedBody['message'];
      if (err.response!.statusCode! == 401 ||
          err.response!.statusCode! == 500) {
        if (message == "Token has expired and can no longer be refreshed" ||
            err.response!.statusCode! == 401) {
          message = "Sesi login telah habis, silahkan login kembali!";
          EventBus().sendEvent("logout");
        } else {
          message = "Server error, silahkan coba lagi";
        }
      }
      throw ErrorException(
        message,
        data: decodedBody['data'],
        statusCode: err.response!.statusCode,
        requestOptions: err.requestOptions,
      );
    }
    handler.next(err);
  }
}

class EventBus {
  static final EventBus _singleton = EventBus._internal();

  factory EventBus() => _singleton;

  EventBus._internal();

  final _eventStream = StreamController<String>.broadcast();

  Stream<String> get eventStream => _eventStream.stream;

  void sendEvent(String eventName) {
    _eventStream.sink.add(eventName);
  }

  void dispose() {
    _eventStream.close();
  }
}
