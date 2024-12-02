
import 'package:dental_ui/core/network/endpoint.dart';
import 'package:dio/dio.dart';

Dio dioInstance() {
  Dio dio = Dio();
  dio.options.baseUrl = Endpoint.baseUrl;
  dio.options.headers = {
    // "AUTHNTOKEN": PreferencesHelper.getString(PreferencesConstant.token),
    // "X-APP-VERSION": PreferencesHelper.getString(Preferences.version) ?? '',
    // "X-TIME-ZONE": PreferencesHelper.getString(Preferences.academyTimeZone) ?? '',
  };
  dio.options.connectTimeout = const Duration(seconds: 10);
  dio.options.receiveTimeout = const Duration(seconds: 10);
  // dio.interceptors.add(CustomInterceptors());
  return dio;
}
