class WeatherInfo {
  final String description;
  final String icon;

  WeatherInfo({required this.description,required this.icon});

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    final description = json['description'];
    final icon = json['icon'];
    return WeatherInfo(description: description, icon: icon);
  }
}

class TemperatureInfo {
  final dynamic temperature;

  TemperatureInfo({required this.temperature});

  factory TemperatureInfo.fromJson(Map<String, dynamic> json) {
    final temperature = json['temp'];
    return TemperatureInfo(temperature: temperature);
  }
}


class MainInfo {
  final dynamic temperature;
  final dynamic feels;
  final dynamic minTemp;
  final dynamic maxTemp;
  final dynamic pressure;
  final dynamic humidity;
  

  MainInfo({required this.temperature,required this.feels,required this.minTemp,required this.maxTemp,required this.pressure,required this.humidity});

  factory MainInfo.fromJson(Map<String, dynamic> json) {
    final temperature = json['temp'];
    final feels = json['feels_like'];
    final minTemp = json['temp_min'];
    final maxTemp = json['temp_max'];
    final pressure = json['pressure'];
    final humidity = json['humidity'];
    return MainInfo(temperature: temperature, feels: feels, minTemp: minTemp, maxTemp: maxTemp, pressure: pressure, humidity: humidity);
  }
}

class WindInfo {
  final dynamic speed;
 
  WindInfo({required this.speed});

  factory WindInfo.fromJson(Map<String, dynamic> json) {
    final speed = json['speed'];
    return WindInfo(speed: speed);
  }
}



class WeatherResponse {
  final String cityName;
  final TemperatureInfo tempInfo;
  final WeatherInfo weatherInfo;
  final MainInfo mainInfo;
  final WindInfo windInfo;

  String get iconUrl {
    return 'https://openweathermap.org/img/wn/${weatherInfo.icon}@2x.png';
  }

  WeatherResponse({required this.cityName, required this.tempInfo, required this.weatherInfo, required this.mainInfo, required this.windInfo});

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

    return WeatherResponse(
        cityName: cityName, tempInfo: tempInfo, weatherInfo: weatherInfo,mainInfo: mainInfo, windInfo: windInfo);
  }
}