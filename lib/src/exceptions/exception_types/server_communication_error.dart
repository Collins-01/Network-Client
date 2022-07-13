import 'package:dio/dio.dart';

import '../../../network_client.dart';

/// errors sent back by the server in json
class ServerCommunicationException extends DioError with Failure {
  ServerCommunicationException(this.r)
      : super(requestOptions: r!.requestOptions);

  /// sustained so that the data sent by the server can be gotten to construct message
  final Response? r;

  @override
  String toString() {
    return 'title: $title message: $message';
  }

  @override
  String get message {
    return getError(r?.data ??
            {
              "message": "A server error has occured, please try again later."
            }) ??
        "A server error has occured, please try again later.";
  }

  @override
  String get title => "Server Error ";

  @override
  int get statusCode => response?.statusCode ?? 000;
}
