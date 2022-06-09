import 'package:flutter/material.dart';
import 'package:sqlite_provider_starter/routes/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: RouteManager.loginPage,
      onGenerateRoute: RouteManager.generateRoute,
    );
  }
}
