import '../../../network_client.dart';
import 'package:dio/dio.dart';

///409
class ConflictException extends DioError with Failure {
  final RequestOptions request;
  final Response? serverResponse;
  ConflictException(this.request, [this.serverResponse])
      : super(requestOptions: request, response: serverResponse);

  @override
  String toString() {
    return "Error was:\nTitle: $title\nMessage: $message ";
  }

  @override
  String get message {
    if (serverResponse == null) {
      return "An error occured, please try again. ";
    }
    return getError(serverResponse?.data['errorMessages']) ??
        "An error occured, please try again.";
  }

  @override
  String get title => "Conflict Error";

  @override
  int get statusCode => response?.statusCode ?? 000;
}
