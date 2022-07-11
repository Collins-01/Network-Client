
## Getting started

`Inspired by my boss 🤲 `EhisEA` `
 

TODO: Copy the Github Url, and add to your pubspec.yaml.
[network_client](https://github.com/Collins-01/Network-Client). 

 ```dart
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.2
  network_client:
    git: https://github.com/Collins-01/Network-Client
```

Run the `flutter pub get` command

## Features
 - Get
 - Post
 - Patch
 - Delete
 - Put
 
 It supports the above listed network request types.

## Usage
 Go to your main.dart file, and initialise the Plugin before your `runApp` method
```dart
  void main(){ 
    NetworkClient.init('my base url')
    runApp(MyApp())
  }
```
 You can specify the SendTimeouts, RecieveTimeOuts, enable and disable logging at the initialisation of the Plugin.

 ```dart
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
 ```

Making use of the Plugin in your service class to make a get request.

```dart
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

```

The final usage in your viewModels, or in your Bloc file.
```dart
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
```
[Here is an example for usage with BLoCs or Cubits](https://github.com/Collins-01/Weather_App_Flutter.git). 

<!-- https://github.com/Collins-01/Weather_App_Flutter.git -->

<!-- 
## Additional information

TODO: Tell users more about the package: where to find more information, how to 
contribute to the package, how to file issues, what response they can expect 
from the package authors, and more. -->
