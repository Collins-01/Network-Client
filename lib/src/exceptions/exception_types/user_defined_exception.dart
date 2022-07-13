import '../../../network_client.dart';

class UserDefinedExceptions extends Failure {
  final String _title;
  final String _message;
  final int? _code;
  UserDefinedExceptions(this._title, this._message, this._code);
  @override
  String get message => _message;

  @override
  String get title => _title;

  @override
  int get statusCode => _code ?? 000;
}
