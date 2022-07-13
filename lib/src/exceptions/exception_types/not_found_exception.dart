import 'package:dio/dio.dart';

import '../../../network_client.dart';

///404
class NotFoundException extends DioError with Failure {
  final RequestOptions request;
  final Response? serverResponse;
  NotFoundException(this.request, [this.serverResponse])
      : super(requestOptions: request, response: serverResponse);

  @override
  String toString() {
    // log(serverResponse.toString());
    return "Error was: Not found";
    // return "Error was:\nTitle: $title\nMessage: $message ";
  }

  @override
  String get message {
    if (serverResponse == null) {
      return "Not found, please try again";
    }
    return getError(serverResponse?.data['errorMessages']) ??
        "Not found, please try again";
    // return "Not Found!. ";
  }

  @override
  String get title {
    // if (serverResponse != null) {
    //   return serverResponse?.data?["message"] ?? "Not Found.";
    // }
    return "Not Found";
  }

  @override
  int get statusCode => response?.statusCode ?? 000;
}
