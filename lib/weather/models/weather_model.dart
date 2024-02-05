
class Weather {
   final String name;
  final dynamic main;
  final dynamic wind;
  final dynamic weather;
  final int humidity;
  final DateTime date;
 final String description;
 final double maxTemperature;
  final double minTemperature;
    final double windSpeed;

  Weather(
    {
    required this.main,
    required this.name,
    required this.weather,
    required this.wind,
    required this.humidity,
    required this.date,
   required this.description,
    required this.maxTemperature,
    required this.minTemperature,
    required this.windSpeed
      });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      name: json['name'],
      wind: json['wind'],
      weather: json['weather'],
      main: json['main'],
      humidity: json['main']['humidity'],
      date: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
      description: json['weather'][0]['description'],
      maxTemperature: json['main']['temp_max'].toDouble(),
      minTemperature: json['main']['temp_min'].toDouble(),
      windSpeed: json['wind']['speed'].toDouble(),
      
    );
  }
}







/*class Weather{
  final String cityName;
  final double temperature;
  final double humidity;
  final double wind;
  final double mainCondition;
  

Weather(
  {
    required this.cityName,
    required this.wind,
    required this.mainCondition,
    required this.humidity,
    required this.temperature
  }
);

factory Weather.fromJson(Map<String, dynamic> json){
  return Weather(
    cityName: json['name'], 
    mainCondition: json['mainCondition'], 
    wind: json['wind'], 
    humidity: json['humidity'], 
    temperature: json['temp']
    );
}

}*/

