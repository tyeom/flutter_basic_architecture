import 'package:basic_architecture/App/app.dart';
import 'package:basic_architecture/Injectable/configurations.dart';
import 'package:flutter/material.dart';

main() => App.run();

class App {
  App();

  static Future<void> run() async {
    WidgetsFlutterBinding.ensureInitialized();
    await configureDependencies();
    runApp(const MyApp());
  }
}
