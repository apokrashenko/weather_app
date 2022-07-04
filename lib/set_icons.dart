import 'package:flutter/material.dart';

class MyIcons extends StatelessWidget {
  const MyIcons({Key? key, required this.weatherInfo}) : super(key: key);

  final String weatherInfo;

  @override
  Widget build(BuildContext context) {
    return Icon((() {
      switch(weatherInfo){
        case 'clear sky':
          return Icons.wb_sunny_outlined;
        case 'few clouds':
          return Icons.wb_cloudy_outlined;
        case 'scattered clouds':
          return Icons.wb_cloudy;
        case 'broken clouds':
          return Icons.wb_cloudy;
        case 'shower rain':
          return Icons.water_drop;
        case 'rain':
          return Icons.water_drop_outlined;
        case 'thunderstorm':
          return Icons.thunderstorm_outlined;
        case 'snow':
          return Icons.ac_unit_outlined;
        case 'mist':
          return Icons.foggy;
      }
    })(),
    color: Colors.amber[800],
    size: 50,
    );
  }
}