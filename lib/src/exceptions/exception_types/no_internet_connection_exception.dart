import 'package:dio/dio.dart';

import '../../../network_client.dart';

///No Internet Connection
class NoInternetConnectionException extends DioError with Failure {
  NoInternetConnectionException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'title: $title message: $message';
  }

  @override
  String get message => "No internet connection, please try again";

  @override
  String get title => "No Network";

  @override
  int get statusCode => response?.statusCode ?? 000;
}
