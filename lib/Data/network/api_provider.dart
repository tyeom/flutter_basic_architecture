import 'package:basic_architecture/Data/network/api_endpoint.dart';
import 'package:basic_architecture/Data/network/auth_token_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

enum ApiType { base, sampleData }

abstract class ApiProviderFactory {
  Dio get getDio;

  factory ApiProviderFactory(ApiType type, bool enableLogger,
      {BaseOptions? options}) {
    switch (type) {
      case ApiType.base:
        return ApiProvider(enableLogger, options: options);
      case ApiType.sampleData:
        return SampleDataApiProvider(enableLogger, options: options);
    }
  }
}

/// 기본 RestFul API
/// Basic RestFul API
class ApiProvider implements ApiProviderFactory {
  static const int apiTimeOut = 60000;
  static late Dio dio;

  bool enableLogger;

  ApiProvider(this.enableLogger, {BaseOptions? options}) {
    final dioInstance = Dio(options ?? BaseOptions()
      ..baseUrl = ApiEndpoint.baseUrl
      ..connectTimeout = const Duration(milliseconds: apiTimeOut)
      ..receiveTimeout = const Duration(milliseconds: apiTimeOut)
      ..headers = <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
        'accept': 'application/json',
      });

    if (enableLogger) {
      dioInstance.interceptors.add(PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
          maxWidth: 90));
    }

    const storage = FlutterSecureStorage();
    dioInstance.interceptors.add(AuthTokenDioInterceptor(storage: storage));
    dio = dioInstance;
  }

  @override
  Dio get getDio => dio;
}

/// 테스트용 데이터 Web API
/// Sample data call web api
class SampleDataApiProvider implements ApiProviderFactory {
  static const int apiTimeOut = 60000;
  static late Dio dio;

  bool enableLogger;

  SampleDataApiProvider(this.enableLogger, {BaseOptions? options}) {
    final dioInstance = Dio(options ?? BaseOptions()
      ..baseUrl = ApiEndpoint.baseUrlSampleData
      ..connectTimeout = const Duration(milliseconds: apiTimeOut)
      ..receiveTimeout = const Duration(milliseconds: apiTimeOut)
      ..headers = <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
        'accept': 'application/json',
      });

    if (enableLogger) {
      dioInstance.interceptors.add(PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
          maxWidth: 90));
    }

    dio = dioInstance;
  }

  @override
  Dio get getDio => dio;
}
