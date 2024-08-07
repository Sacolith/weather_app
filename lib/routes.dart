import 'package:flutter/material.dart';
import 'package:weather_app/screens/forecast_screen.dart';
import 'package:weather_app/screens/home_sreen.dart';
import 'package:weather_app/screens/settings_screen.dart';

class Routes{
  static Map<String, WidgetBuilder> getRoutes(){
    return{
      '/forecast': (context)=> const ForecastScreen(city: 'texas',),
      '/home': (context)=> const HomeScreen(),
      '/settings':(context)=> const SettingScreen()
    };
  }
}