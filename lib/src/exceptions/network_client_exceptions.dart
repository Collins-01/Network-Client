import 'package:dio/dio.dart';
import './failure.dart';

/// User defined Exceptions
class UserDefinedExceptions extends Failure {
  final String _title;
  final String _message;
  UserDefinedExceptions(this._title, this._message);
  @override
  String get message => _message;

  @override
  String get title => _title;
}

/// 400 Response
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
      return "An error occured, please try again. ";
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
}

///500 Response
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
}

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
}

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
  // String get title => serverResponse?.data?["message"] ?? "Access denied.";
}

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
}

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
}

///Time Out Exception [When there is a connection timeou with the request]
class DeadlineExceededException extends DioError with Failure {
  DeadlineExceededException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'title: $title message: $message';
  }

  @override
  String get message => "The connection has timed out, please try again.";

  @override
  String get title => "Network error";
}

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
}

class TestException extends DioError with Failure {
  final Response? serverResponse;
  final RequestOptions requestOptions;
  TestException(this.requestOptions, [this.serverResponse])
      : super(
          requestOptions: requestOptions,
          response: serverResponse,
        );

  @override
  String get message => "An unknown error occured, please try again.";

  @override
  String get title => "Network Error";
}

class RequestUnknownExcpetion extends DioError with Failure {
  final Response? serverResponse;
  final RequestOptions requestOptions;
  RequestUnknownExcpetion(this.requestOptions, [this.serverResponse])
      : super(
          requestOptions: requestOptions,
          response: serverResponse,
        );

  @override
  String get message => "An unknown error occured, please try again later.";

  @override
  String get title => "Unkown Error";
}
