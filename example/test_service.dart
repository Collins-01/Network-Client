import 'package:network_client/network_client.dart';

class TestService {
  final NetworkClient _client = NetworkClient();
  Future<void> getTest() async {
    try {
      var response = await _client.get('uri');
      //Decode and use respoonse here
    } on Failure {
      rethrow;
    }
  }
}

class MYViewModel {
  final TestService _testService = TestService();

  useTest() async {
    try {
      await _testService.getTest();
    } on Failure catch (e) {
      print(e.message);
      print(e.title);
    }
  }
}
