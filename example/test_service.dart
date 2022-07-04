import 'package:network_client/network_client.dart';

class TestService {
  final NetworkClient _client = NetworkClient();
  getTest() async {
    await _client.get('uri');
  }
}
