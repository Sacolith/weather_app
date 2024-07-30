
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:weather_app/widgets/forecast_widget.dart';

class ForecastScreen extends StatelessWidget{
  final List<Map<String, dynamic>> forecast =[
    {'day': 'Monday', 'description': 'Sunny', 'temperature': 25.0},
    {'day': 'Tuesday', 'description': 'Cloudy', 'temperature': 22.0},
    {'day': 'Wednesday', 'description': 'Rainy', 'temperature': 20.0},
    // Add more forecast data here...
  ];
 ForecastScreen({super.key});


@override
Widget build(BuildContext context){
  return Scaffold(
    appBar: AppBar(
      title: const Text('Weather Forecast'),
    ),
    body:  ListView.builder(
      itemCount: forecast.length,
      itemBuilder:(context, index){
        return ForecastWidget(
          day: forecast[index]['day'],
          description: forecast[index]['description'],
          temperature:forecast[index]['temperature'], forecast: const [],
        );
      },),
  );
}
}