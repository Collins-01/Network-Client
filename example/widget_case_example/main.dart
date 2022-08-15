import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp();
  }
}

class NetworkClientProviderWidget extends StatelessWidget {
  final Widget child;
  const NetworkClientProviderWidget({Key? key, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return child;
  }
}

class NetworkClientProvider extends InheritedWidget {
  const NetworkClientProvider({Key? key, required this.child})
      : super(key: key, child: child);

  final Widget child;

  static NetworkClientProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<NetworkClientProvider>();
  }

  @override
  bool updateShouldNotify(NetworkClientProvider oldWidget) {
    return true;
  }
}

class NetworkClientConfig extends ChangeNotifier
    with NetworkClientConfigInterface {
  final AuthService _authService;
  NetworkClientConfig(this._authService);
  @override
  String get token => _authService.token;
}

abstract class NetworkClientConfigInterface {
  String get token;
}

class AuthService {
  final String token = '';
}
