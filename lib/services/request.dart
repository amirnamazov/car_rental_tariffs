import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

typedef OnSuccess = void Function(int? statusCode, String? response);
typedef OnFailure = void Function(int? statusCode, String? response);
typedef OnError = void Function(String? response);
typedef OnComplete = void Function();

class RequestClient {
  static RequestClient? _requestClinet;
  static Dio? _dio;
  static String baseUrl = 'https://crm.getmancar.com.ua/';
  static int _timeout = 20000;

  RequestClient._createInstance();

  factory RequestClient() {
    if (_requestClinet == null) {
      _requestClinet = RequestClient._createInstance();
      _configDio();
    }
    return _requestClinet!;
  }

  static _configDio() {
    _dio = Dio();
    BaseOptions options = new BaseOptions(
      connectTimeout: _timeout,
      receiveTimeout: _timeout,
      responseType: ResponseType.plain,
    );

    _dio!.options = options;

    _dio!.interceptors.add(InterceptorsWrapper(
      onResponse: (response, handler) {
        return _responseInterceptor(response, handler);
      },
    ));

    (_dio!.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }

  Future<void> get({
    required String endPoint,
    Map<String, String>? header,
    Map<String, dynamic>? queryParam,
    required OnSuccess onSuccess,
    required OnFailure onFailure,
    required OnError onError,
    OnComplete? onComplete,
  }) async {
    _dio!.options.headers.clear();

    _dio!.options.baseUrl = baseUrl;

    if (header != null) {
      _dio!.options.headers.addAll(header);
    }

    try {
      Response response = await _dio!.get(endPoint, queryParameters: queryParam);
      onSuccess(response.statusCode!, response.data.toString());
    } on DioError catch (e) {
      if (e.response != null) {
        onFailure(e.response!.statusCode, e.response!.data.toString());
      } else {
        onError(e.error.toString());
      }
    } on Exception catch (e) {
      onError(e.toString());
    } finally {
      onComplete!();
    }
  }

  static dynamic _responseInterceptor(
      Response response, ResponseInterceptorHandler handler) {
    return handler.next(response);
  }
}
