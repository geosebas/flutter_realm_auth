import 'package:flutter/material.dart';
import 'package:realm/realm.dart';

import 'router_manager.dart';

const String _appId = 'add your mongodb realm app id here';
final AppConfiguration _appConfig = AppConfiguration(_appId);
final App app = App(_appConfig);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/',
      onGenerateRoute: RouterManager.generateRoute,
    );
  }
}
