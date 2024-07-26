import 'package:flutter/material.dart';

import '../models/weather_model.dart';

class ForecastWidget extends StatelessWidget{
  final List<Weather> forecast;
  const ForecastWidget({super.key, required this.forecast, required day, required description, required temperature});

  @override
  Widget build(BuildContext context){
    return Column(
      children: forecast.map((weather){
        return Card(
          child: ListTile(
            hoverColor: Colors.amber,
            title: Text(weather.location),
            subtitle: Text(weather.description),
            trailing: Text('${weather.temperature.toStringAsFixed(1)}°C'),
          ),
        );
      }).toList()
    );
  }
}