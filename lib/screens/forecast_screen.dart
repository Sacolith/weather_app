// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/widgets/forecast_widget.dart';

class ForecastScreen extends StatefulWidget {
  final String city;

  const ForecastScreen({super.key, required this.city});

  @override
  State<ForecastScreen> createState() => _ForecastScreenState();
}

class _ForecastScreenState extends State<ForecastScreen> {
  late Future<List<WeatherForecast>> _forecast;

  @override
  void initState() {
    super.initState();
    _forecast = WeatherService().fetchforecast(widget.city, 5); // Fetch 5 days of forecast data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Forecast'),
      ),
      body: FutureBuilder<List<WeatherForecast>>(
        future: _forecast,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No forecast data available'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final forecast = snapshot.data![index];
                return ForecastWidget(
                  day: forecast.date,
                  description: forecast.description,
                  temperature: forecast.temperature,
                );
              },
            );
          }
        },
      ),
    );
  }
}
