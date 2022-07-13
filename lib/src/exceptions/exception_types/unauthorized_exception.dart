import 'package:dio/dio.dart';

import '../../../network_client.dart';

///401
class UnAuthorizedException extends DioError with Failure {
  final RequestOptions request;
  final Response? serverResponse;
  UnAuthorizedException(this.request, [this.serverResponse])
      : super(requestOptions: request, response: serverResponse);

  @override
  String toString() {
    // return "An UnAuthorized request";
    return "Error was:\nTitle: $title\nMessage: $message ";
  }

  @override
  String get message {
    // if (serverResponse == null) {
    //   return "User is UnAuthorized";
    // }
    // return getError(serverResponse?.data['errorMessages']) ??
    //     "User is UnAuthorized";
    return "User is UnAuthorized";
  }
  // getError(serverResponse?.data["errors"]) ?? "Invalid request.";

  @override
  String get title => "Access denied.";

  @override
  int get statusCode => response?.statusCode ?? 000;
  // String get title => serverResponse?.data?["message"] ?? "Access denied.";
}
