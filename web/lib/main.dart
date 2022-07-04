// ignore_for_file: unused_import

import 'package:weather_app/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/data_service.dart';
import 'package:weather_app/weather_model.dart';
import 'package:weather_app/set_icons.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/':(context) =>  const MainScreen(),
       // 'settings':(context) => Settings(),
      },
      
    );
  }
}
