import 'package:dio/dio.dart';
import 'package:network_client/src/exceptions/exceptions.dart';

class NetworkInterceptors extends Interceptor {
  final Dio dio;
  String? token;
  final Map<String, dynamic> errorObject;
  NetworkInterceptors(this.dio, {this.errorObject = const {}});
  @override
  Future<dynamic> onError(DioError err, ErrorInterceptorHandler handler) async {
    switch (err.type) {
      case DioErrorType.connectTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        err = DeadlineExceededException(err.requestOptions);
        break;
      case DioErrorType.response:
        if (err.response != null) {
          switch (err.response?.statusCode) {
            case 400:
              err = BadRequestException(err.requestOptions, err.response);
              break;
            case 401:
              err = UnAuthorizedException(err.requestOptions, err.response);
              break;
            case 403:
              err = UnAuthorizedException(err.requestOptions, err.response);
              break;
            case 404:
              err = NotFoundException(err.requestOptions, err.response);
              break;
            case 409:
              err = ConflictException(err.requestOptions, err.response);
              break;
            case 500:
              err = InternalServerErrorException(
                  err.requestOptions, err.response);
              break;
            case 503:
              err = ServerCommunicationException(err.response);
              break;
            default:
              err = RequestUnknownExcpetion(err.requestOptions, err.response);
              break;
          }
        } else {
          err = RequestUnknownExcpetion(err.requestOptions, err.response);
        }
        break;
      case DioErrorType.cancel:
        break;
      case DioErrorType.other:
        err = NoInternetConnectionException(err.requestOptions);
        break;
    }
    return handler.next(err);
  }

  @override
  Future<dynamic> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // checkStatusCode(options, null);
    return handler.next(options);
  }

  @override
  Future<dynamic> onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    checkStatusCode(response.requestOptions, response);
    return handler.next(response);
  }

  void checkStatusCode(
    RequestOptions requestOptions,
    Response? response,
  ) async {
    try {
      switch (response?.statusCode) {
        case 200:
        case 204:
        case 201:
          break;
        case 400:
          throw BadRequestException(requestOptions, response);
        case 401:
          throw UserDefinedExceptions(
              "Access Denied", "Please login and try again.");
        case 404:
          throw NotFoundException(requestOptions);
        case 409:
          throw ConflictException(requestOptions, response);
        case 500:
          throw InternalServerErrorException(requestOptions);
        default:
          throw ServerCommunicationException(response);
      }
    } on Failure {
      rethrow;
    }
  }
}
