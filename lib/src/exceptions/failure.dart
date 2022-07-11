import 'package:network_client/src/exceptions/exceptions.dart';

abstract class Failure {
  ///Exposes the Error title, and message
  String get title;
  String get message;

  /// Returns  true if error is a network connection problem
  bool get isInternetConnectionError =>
      runtimeType is NoInternetConnectionException;

  /// Decodes the Error from the server, and casts it to a nullable string
  String? getError(error) {
    try {
      if (error is String) {
        return error;
      } else if (error is List) {
        return error[0] is String ? error[0] : error[0][0];
      }
      final item = (error as Map).values.toList()[0];
      if (item is List) {
        // ? stirng : list / map
        return item[0] is String ? item[0] : item[0][0];
      }
      return item is String ? item : null;
    } catch (e) {
      return null;
    }
  }
}
