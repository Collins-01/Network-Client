import '../../../network_client.dart';
import 'package:dio/dio.dart';

const _unkownErrorString = "An error occured, please try again. ";

class BadRequestException extends DioError with Failure {
  final RequestOptions request;
  final Response? serverResponse;
  final Map<String, dynamic> errorObject;
  BadRequestException(this.request,
      [this.serverResponse, this.errorObject = const {}])
      : super(requestOptions: request, response: serverResponse);

  @override

  /// The title of your error, returns "An Error Occured if Null"
  String get title => "Invalid Request";
  @override
  String get message {
    if (serverResponse == null) {
      return _unkownErrorString;
    }
    if (errorObject.isNotEmpty) {
      final key = errorObject.keys.first;

      if (getError(serverResponse?.data[key]) == null) {
        return "An error occured, please try again.";
      }
      return getError(serverResponse?.data[key])!;
    }
    return "An error occured, please try again.";
  }

  @override
  String toString() {
    return "Error was:\nTitle: $title\nMessage: $message ";
  }

  @override
  int get statusCode => response?.statusCode ?? 000;
}
