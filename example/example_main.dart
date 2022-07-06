import 'package:flutter/material.dart';
import 'package:network_client/network_client.dart';

void main() {
  /// Token can be fetched from your cache or sustained from your AuthService
  String token = '';

  NetworkClient.init(
    'my url',
    connectTimeout: 50000,
    enableLogging: true,
    headers: {
      "Authorization": "Bearer $token",
    },
    receiveTimeout: 60000,
    sendTimeout: 40000,
  );
}
