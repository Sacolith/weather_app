import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_app/routes.dart';

void main() async{
  await dotenv.load(fileName: "assets/.env");
  runApp(const MainApp());
}
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      initialRoute: '/home',
      routes: Routes.getRoutes(),
    );
  }
}
