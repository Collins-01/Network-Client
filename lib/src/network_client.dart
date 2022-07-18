import 'package:dio/dio.dart';

import 'package:network_client/src/exceptions/exceptions.dart';
import 'package:network_client/src/mixins/mixins.dart';
import 'package:network_client/src/network_client_interceptors/network_client_interceptors.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

/*
Error Response:

 {
  "errorMessages": [
    "string"
  ],
  "status": 100,
  "isSuccess": true
}

*/

class NetworkClient with NetworkClientMixin {
  NetworkClient._();
  static final NetworkClient _instance = NetworkClient._();
  factory NetworkClient() => _instance;
  static String _baseURL = '';

  static Map<String, dynamic>? _headers;
  static bool _enableLogging = false;
  static int _receiveTimeout = 40000;
  static int _connectTimeout = 40000;
  static int _sendTimeout = 60000;
  static Map<String, dynamic> _errorObject = {};
  static init(
    String url, {
    Map<String, dynamic>? headers,
    bool enableLogging = false,
    int receiveTimeout = 40000,
    int connectTimeout = 40000,
    int sendTimeout = 60000,
    Map<String, dynamic> errorObject = const {},
  }) {
    _baseURL = url;
    _headers = headers;
    _enableLogging = enableLogging;
    _receiveTimeout = receiveTimeout;
    _connectTimeout = connectTimeout;
    _sendTimeout = sendTimeout;
    if (errorObject.isNotEmpty) {
      _errorObject = errorObject;
    }
  }

  final Dio _dio = _createDio();

  ///Initialises the Dio Variable
  static Dio _createDio() {
    var dio = Dio(
      BaseOptions(
        baseUrl: _baseURL,
        receiveTimeout: _receiveTimeout, // 15 seconds
        connectTimeout: _connectTimeout,
        sendTimeout: _sendTimeout,
      ),
    );

    /// Adds our Custom Interceptos to the DIO Interceptors
    dio.interceptors.add(NetworkInterceptors(
      dio,
      errorObject: _errorObject,
    ));
    if (_enableLogging) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
          maxWidth: 90,
        ),
      );
    }

    return dio;
  }

  ///Makes a [GET] request and returns data of type[T]
  Future<T> get<T>(
    /// the api route path without the base url
    String uri, {
    Map<String, dynamic> queryParameters = const {},
    // Options options,
    Map<String, dynamic>? requestHeaders,
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
        options: Options(
          headers: requestHeaders ?? _headers,
        ),
      );
      // checkRequest(response);
      return response.data;
    } on Failure {
      rethrow;
    }
  }

  ///[POST] sends a post request to the server.
  Future<dynamic> post(
    /// the api route without the base url
    String uri, {

    ///this are query parameters that would
    /// be attached to the url
    /// [e.g]=>{"a":"yes"}
    /// https://she.com/getPeople?a=yes
    Map<String, dynamic> queryParameters = const {},
    Object? body,
    Map<String, dynamic>? requestHeaders,
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
          headers: requestHeaders ?? _headers,
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
    Map<String, dynamic>? requestHeaders,
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
          headers: requestHeaders ?? _headers,
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
    Map<String, dynamic>? requestHeaders,
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
          headers: requestHeaders ?? _headers,
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
    Map<String, dynamic>? requestHeaders,
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
          headers: requestHeaders ?? _headers,
        ),
      );
      return response.data;
    } on Failure {
      rethrow;
    }
  }
}
