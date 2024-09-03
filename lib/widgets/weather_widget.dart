import 'package:flutter/widgets.dart';
import 'package:weather_app/models/weather_model.dart';

//responsible for the look of the retrieved weather Data
class WeatherWidget extends StatelessWidget{
  final Weather weather;
  const WeatherWidget({super.key, required this.weather});

  @override
  Widget build(BuildContext context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Location: ${weather.location}',
          style: const TextStyle(fontSize: 20),
        ),
        Text('Temperature: ${weather.temperature}',
        style: const TextStyle(fontSize: 20),),
        Text('Description: ${weather.description}',
        style: const TextStyle(fontSize: 20),),
              Text('Time: ${weather.localtime}',
        style: const TextStyle(fontSize: 20),),
      ],);
  }
}