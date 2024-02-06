import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class Log {
  static final Logger _instance = Logger(printer: SimplePrinter());
  static final Logger _routeLogger = Logger(printer: LogfmtPrinter());

  static final Interceptor _dioLogger = PrettyDioLogger(
    request: true,
    requestHeader: true,
    requestBody: true,
    responseHeader: false,
    responseBody: true,
    error: true,
    compact: true,
    maxWidth: 120,
  );
  static Interceptor get dioLogger => _dioLogger;

  static route(String message) {
    _routeLogger.d(message);
  }

  static i(dynamic message) {
    _instance.i(message);
  }

  static e(dynamic message, {StackTrace? stackTrace}) {
    _instance.e(message, null, stackTrace);
  }

  static wtf(dynamic message) {
    _instance.wtf(message);
  }
}
