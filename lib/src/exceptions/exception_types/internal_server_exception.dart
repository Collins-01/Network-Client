import 'package:dio/dio.dart';

import '../../../network_client.dart';

class InternalServerErrorException extends DioError with Failure {
  final RequestOptions request;
  final Response? serverResponse;
  InternalServerErrorException(this.request, [this.serverResponse])
      : super(requestOptions: request, response: serverResponse);

  @override
  String toString() {
    return "Error was:\nTitle: $title\nMessage: $message ";
  }

  @override
  String get title => "Server Error";
  @override
  String get message => "An Unknown error occcured, please try again later";

  @override
  int get statusCode => response?.statusCode ?? 000;
}
