import 'package:flutter/material.dart';

import 'login_view.dart';
import 'register_view.dart';
import 'home_view.dart';

class RouterManager {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomeView());
      case 'login':
        return MaterialPageRoute(builder: (_) => const LoginView());
      case 'register':
        return MaterialPageRoute(builder: (_) => const RegisterView());
      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          );
        });
    }
  }
}
