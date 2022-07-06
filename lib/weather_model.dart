import 'package:intl/intl.dart';

class WeatherInfo {
  final String description;
  final String icon;

  WeatherInfo({required this.description, required this.icon});

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    final description = json['description'];
    final icon = json['icon'];
    return WeatherInfo(description: description, icon: icon);
  }
}

class TemperatureInfo {
  final double temperature;

  TemperatureInfo({required this.temperature});

  factory TemperatureInfo.fromJson(Map<String, dynamic> json) {
    final temperature = (json['temp']).toDouble();
    return TemperatureInfo(temperature: temperature);
  }
}

class MainInfo {
  final double temperature;
  final double tempFeelsLike;
  final double minTemp;
  final double maxTemp;
  final int pressure;
  final int humidity;

  MainInfo(
      {required this.temperature,
      required this.tempFeelsLike,
      required this.minTemp,
      required this.maxTemp,
      required this.pressure,
      required this.humidity});

  factory MainInfo.fromJson(Map<String, dynamic> json) {
    final temperature = (json['temp']).toDouble();
    final tempFeelsLike = (json['feels_like']).toDouble();
    final minTemp = (json['temp_min']).toDouble();
    final maxTemp = (json['temp_max']).toDouble();
    final pressure = (json['pressure']).toInt();
    final humidity = (json['humidity']).toInt();
    return MainInfo(
        temperature: temperature,
        tempFeelsLike: tempFeelsLike,
        minTemp: minTemp,
        maxTemp: maxTemp,
        pressure: pressure,
        humidity: humidity);
  }
}

class WindInfo {
  final double speed;

  WindInfo({required this.speed});

  factory WindInfo.fromJson(Map<String, dynamic> json) {
    final speed = (json['speed']).toDouble();
    return WindInfo(speed: speed);
  }
}

class WeatherResponse {
  final String cityName;
  final TemperatureInfo tempInfo;
  final WeatherInfo weatherInfo;
  final MainInfo mainInfo;
  final WindInfo windInfo;
  final String dateTime;
  final int timeZone;

  String get iconUrl {
    return 'https://openweathermap.org/img/wn/${weatherInfo.icon}@2x.png';
  }

  WeatherResponse(
      {required this.cityName,
      required this.tempInfo,
      required this.weatherInfo,
      required this.mainInfo,
      required this.windInfo,
      required this.dateTime,
      required this.timeZone});

  factory WeatherResponse.fromJson(Map<String, dynamic> json) {
    final cityName = json['name'];

    final tempInfoJson = json['main'];
    final tempInfo = TemperatureInfo.fromJson(tempInfoJson);

    final weatherInfoJson = json['weather'][0];
    final weatherInfo = WeatherInfo.fromJson(weatherInfoJson);

    final mainInfoJson = json['main'];
    final mainInfo = MainInfo.fromJson(mainInfoJson);

    final windInfoJson = json['wind'];
    final windInfo = WindInfo.fromJson(windInfoJson);

    final currentDate = json['dt'];
    final dateTime = DateFormat.yMMMMd('en_US')
        .format(DateTime.fromMillisecondsSinceEpoch(currentDate * 1000));

    final timeZone = json['timezone'];

    return WeatherResponse(
        cityName: cityName,
        tempInfo: tempInfo,
        weatherInfo: weatherInfo,
        mainInfo: mainInfo,
        windInfo: windInfo,
        dateTime: dateTime,
        timeZone: timeZone);
  }
}
