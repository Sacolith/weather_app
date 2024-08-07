import 'package:flutter/material.dart';

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
    return Card(
      child: ListTile(
        title: Text(day),
        subtitle: Text(description),
        trailing: Text('${temperature.toStringAsFixed(1)}°C'),
      ),
    );
  }
}
