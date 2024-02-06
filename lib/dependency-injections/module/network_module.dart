import 'dart:io';

import 'package:goresy/data/network/constants/endpoints.dart';
import 'package:goresy/data/app_shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:goresy/utils/logger.dart';

abstract class NetworkModule {
  static Dio provideDio(AppSharedPreferences sharedPrefHelper) {
    final dio = Dio();

    dio
      ..options.baseUrl = Endpoints.baseUrl
      ..options.connectTimeout = Endpoints.connectionTimeout
      ..options.receiveTimeout = Endpoints.receiveTimeout
      ..options.headers = {'Content-Type': 'application/json; charset=utf-8'}
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest:
              (RequestOptions options, RequestInterceptorHandler handler) {
            final preferedLocale = sharedPrefHelper.preferedLanguage.value;
            var acceptLanguages = <String>[];
            if (preferedLocale != null) {
              acceptLanguages.add(preferedLocale);
            }
            if (!acceptLanguages
                .any((lang) => Platform.localeName.startsWith(lang))) {
              acceptLanguages.add(Platform.localeName);
            }

            options.headers.putIfAbsent(
                "Accept-Language", () => acceptLanguages.join(","));

            final token = sharedPrefHelper.accessToken.value;
            if (token != null) {
              options.headers.putIfAbsent('Authorization', () => token);
            }

            return handler.next(options);
          },
        ),
      )
      ..interceptors.add(Log.dioLogger);

    return dio;
  }
}
