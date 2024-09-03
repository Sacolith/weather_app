
class Weather {
  final String description;
  final double temperature;
  final String location;
  final String localtime;
  

  Weather({
    required this.description,
    required this.temperature,
    required this.location,
    required this.localtime
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      localtime: json['localtime'],
      description: json['weather'][0]['description'],
      temperature: json['main']['temp'],
      location: json['name'],
    );
  }

   
}

class WeatherForecast{
  final String date;
  final double temperature;
  final String description;
  final String location;

  WeatherForecast({
    required this.date,required this.description, required this.location,required this.temperature
  });
  

  factory WeatherForecast.fromJson(Map<String, dynamic> json, String location){
    return WeatherForecast(
      date: json['date'] ?? 'Unknown date',
     description: json['day']['condition']['text']?? 'no description',
       temperature: (json['day']['avgtemp_c'] ?? 0.0).toDouble(),
       location: location,
       );


  }
}
