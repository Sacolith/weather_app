import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService{
  final String baseUrl= dotenv.get('URL_KEY');
  final String apiKey= dotenv.get('API_KEY');
  late final Weather weather;
 
  

  Future<Weather> fetchWeather(String city) async{
    final response= await http.get(
      Uri.parse('$baseUrl/current.json?key=$apiKey&q=$city'),
    );

    if(response.statusCode==200){
      final data= json.decode(response.body);
       debugPrint(city);
      return Weather(
        localtime: data['location']['localtime'],
        description: data['current']['condition']['text'],
        temperature: data['current']['temp_c'],
        location: data['location']['name'],
         );
       
    } else{
      throw Exception('Failed to load weather data');
    }
  }

  Future<List<WeatherForecast>> fetchforecast(String city, int days ) async{
    final response= await http.get(
      Uri.parse('$baseUrl/forecast.json?key=$apiKey&q=$city&days=$days'),
    );
    if(response.statusCode==200){
     final data= json.decode(response.body);
     debugPrint(response.body);
     final forecastList=(
      data['forecast']['forecastday'] as List).map
      ((item)=> WeatherForecast.fromJson(
      item,data['location']['name']))
     .toList();
     return forecastList;
    } else{
      throw Exception('Failed to Load forecast data');
    }
  }


}