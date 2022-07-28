import 'package:flutter/material.dart';
import 'package:network_client/network_client.dart';

void main() {
  /// Token can be fetched from your cache or sustained from your AuthService
  WidgetsFlutterBinding.ensureInitialized();

  String token = '';

  NetworkClient.init(
    'my url',
    connectTimeout: 50000,
    enableLogging: true,
    errorObject: {
      'message': ['A is not a number', '1 is not an alphabet']
    },
    headers: {
      "Authorization": "Bearer $token",
    },
    receiveTimeout: 60000,
    sendTimeout: 40000,
  );
}

var e = {
  'status': 'Can be anything',
  'error': [] // can be array, map, , int, double , or string
};
/*
if the error key is specified, it will be easy to get the error message. 
  the key above id  `error`
*/