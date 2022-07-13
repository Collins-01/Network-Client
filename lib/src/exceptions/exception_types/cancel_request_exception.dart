import 'package:dio/dio.dart';
import 'package:network_client/network_client.dart';

class CancelRequestException extends DioError with Failure {
  final RequestOptions requestOptions;
  CancelRequestException(this.requestOptions)
      : super(requestOptions: requestOptions);
  @override
  String get message => "Request was cancelled, please try again.";

  @override
  int get statusCode => 000;

  @override
  String get title => "Request Cancelled";
}
