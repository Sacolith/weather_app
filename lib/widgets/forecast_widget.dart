import 'package:flutter/material.dart';
import 'package:weather_app/design/colors.dart';

//responsible for the look of the forecast card
class ForecastWidget extends StatelessWidget {
  final String day;
  final String description;
  final double temperature;

  const ForecastWidget({
    super.key,
    required this.day,
    required this.description,
    required this.temperature, 
  });

  @override
  Widget build(BuildContext context) {
    return
    Card(
      color: Colors.black,
      child: ListTile(
        title: Text(day,
        style: const TextStyle(color: Colors.white),),
        subtitle: Text(description,
        style: TextStyle(color: Colors.blue.shade700),),
        trailing: Text('${temperature.toStringAsFixed(1)}°C',
        style: const TextStyle(color: Cols.buttoncol),),
      ),
    );
  }
}
