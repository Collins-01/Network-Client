import 'package:dio/dio.dart';

mixin NetworkClientMixin {
  void checkIfURLInitialised(String url) {
    if (url.isEmpty) {
      throw Exception('URL not initialised exception');
    }
    return;
  }
}
