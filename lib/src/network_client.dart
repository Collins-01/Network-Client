import 'package:dio/dio.dart';

import 'package:network_client/src/exceptions/exceptions.dart';
import 'package:network_client/src/mixins/mixins.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class NetworkClient with NetworkClientMixin {
  NetworkClient._();
  static final NetworkClient _instance = NetworkClient._();
  factory NetworkClient() => _instance;
  static String _baseURL = '';
  static Map<String, dynamic>? _headers;
  static init(String url, {Map<String, dynamic>? headers}) {
    _baseURL = url;
    _headers = headers;
  }

  final Dio _dio = createDio();

  ///Initialises the Dio Variable
  static Dio createDio() {
    var dio = Dio(
      BaseOptions(
        baseUrl: _baseURL,
        receiveTimeout: 40000, // 15 seconds
        connectTimeout: 40000,
        sendTimeout: 60000,
      ),
    );

    /// Adds our Custom Interceptos to the DIO Interceptors
    // dio.interceptors.add(NetworkCoreInterceptors(dio));
    dio.interceptors.add(
      PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
          maxWidth: 90),
    );
    return dio;
  }

  Future<T> get<T>(
    /// the api route path without the base url
    ///
    String uri, {
    Map<String, dynamic> queryParameters = const {},
    // Options options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    checkIfURLInitialised(_baseURL);
    try {
      // token = await _storage.read(key: 'token');
      Response response = await _dio.get(
        uri,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
        options: Options(headers: _headers),
      );
      // checkRequest(response);
      return response.data;
    } on Failure {
      rethrow;
    }
  }

  ///POST
  Future<dynamic> post(
    /// the api route without the base url
    String uri, {

    ///this are query parameters that would
    /// be attached to the url
    /// [e.g]=>{"a":"yes"}
    /// https://she.com/getPeople?a=yes
    Map<String, dynamic> queryParameters = const {},
    Object? body,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    checkIfURLInitialised(_baseURL);
    try {
      Response response = await _dio.post(
        uri,
        queryParameters: queryParameters,
        data: body,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
        options: Options(
          headers: _headers,
        ),
      );
      // checkRequest(response);
      return response.data;
    } on Failure {
      rethrow;
    }
  }

  Future<T> put<T>(
    /// the api route without the base url
    String uri, {

    ///this are query parameters that would
    /// be attached to the url
    /// [e.g]=>{"a":"yes"}
    /// she.com/getPeople?a=yes
    Map<String, dynamic> queryParameters = const {},
    Object body = const {},
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    checkIfURLInitialised(_baseURL);
    try {
      Response response = await _dio.put(
        uri,
        queryParameters: queryParameters,
        data: body,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
        options: Options(
          headers: _headers,
        ),
      );
      // checkRequest(response);
      return response.data;
    } on Failure {
      rethrow;
    }
  }

  Future<T> patch<T>(
    /// the api route without the base url
    String uri, {

    ///this are query parameters that would
    /// be attached to the url
    /// [e.g]=>{"a":"yes"}
    /// she.com/getPeople?a=yes
    Map<String, dynamic> queryParameters = const {},
    Object body = const {},
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    checkIfURLInitialised(_baseURL);
    try {
      Response response = await _dio.patch(
        uri,
        queryParameters: queryParameters,
        data: body,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
        options: Options(
          headers: _headers,
        ),
      );
      // checkRequest(response);
      return response.data;
    } on Failure {
      rethrow;
    }
  }

  Future<T> delete<T>(
    /// the api route path without the base url
    ///
    String uri, {
    Map<String, dynamic> queryParameters = const {},
    // Options options,
    CancelToken? cancelToken,
  }) async {
    checkIfURLInitialised(_baseURL);
    try {
      Response response = await _dio.delete(
        uri,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        options: Options(
          headers: _headers,
        ),
      );
      return response.data;
    } on Failure {
      rethrow;
    }
  }
}
