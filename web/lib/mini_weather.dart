import 'package:flutter/material.dart';

class MiniWeather extends StatefulWidget {
  const MiniWeather({Key? key, required this.icon, required this.day,
  required this.degrees, required this.newColor}) : super(key: key);

  final IconData icon;
  final String degrees;
  final String day ;
  final Color newColor;

  @override
  State<MiniWeather> createState() => _MiniWeatherState();
}

class _MiniWeatherState extends State<MiniWeather> {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 50, 20, 10),
      child: Column(
        children: [
          Text(widget.day, style: const TextStyle(
            fontSize:18,
            color: Colors.white,
            fontFamily: 'Arial',
            fontWeight: FontWeight.w400 
          ),),
          Icon(
            widget.icon,
            color: widget.newColor,
            size: 30,
          ),
          Text(widget.degrees, style: const TextStyle(
            fontSize:16,
            color: Colors.white,
            fontFamily: 'Arial',
            fontWeight: FontWeight.w400 
          ),),
        ],
      ),
    );
  }
}