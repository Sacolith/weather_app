class Weather{
  final String description;
  final double temperature;
  final String location;

  Weather({required this.description,
  required this.temperature, required this.location});

  factory Weather.fromJson(Map<String, dynamic>json){
    return Weather(
      description: json['Weather'][0]['description'],
      temperature: json['main']['temp'],
      location: json['name'],

    );
  }
}