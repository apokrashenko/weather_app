// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:weather_app/mini_weather.dart';
import 'package:weather_app/data_service.dart';
import 'package:weather_app/weather_model.dart';
import 'package:weather_app/set_icons.dart';
import 'package:weather_app/local_time.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _cityTextController = TextEditingController();

  final _dataService = DataService();

  WeatherResponse? _response;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color.fromARGB(255, 7, 212, 68), Color.fromARGB(255, 173, 248, 210)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              )
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 15, 10, 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () async {
                          
                        },
                        icon: const Icon(
                          Icons.menu,
                          size: 30,
                          color: Colors.white,
                          )
                        ),
                      const Text('Weather', style: TextStyle(
                        fontFamily: 'Arial',
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.w400
                      ),),
                      IconButton(
                        onPressed: (){},
                        icon: const Icon(
                          Icons.search,
                          size: 30,
                          color: Colors.white,
                        )
                      )
                    ],
                    ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    children: [
                      Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:  [
                        SizedBox(
                          width: 300,
                          height: 40,
                          child: Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.fromLTRB(5, 10, 40, 5),
                            child: TextField(
                              style: TextStyle(color: Colors.grey[600], fontSize: 18),
                              controller: _cityTextController,
                              decoration: const InputDecoration(
                                icon: Icon(Icons.home_outlined, color: Colors.white, size: 40),
                                isCollapsed: true,
                                labelText: 'City',
                                iconColor: Colors.white,
                                contentPadding: EdgeInsets.all(5),
                              ),
                              textAlign: TextAlign.center
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: _search,
                          child: const Text('Search', style:  TextStyle(color:Colors.yellow, fontSize: 14))
                        ),
                        if(_response != null)
                          Text(_response!.cityName, style: const TextStyle(
                            fontFamily: 'Arial',
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Colors.white
                          )),
                          if(_response?.dateTime != null)
                            LocalTime(dateTime:_response?.dateTime )
                      ],
                      ),]
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children:  [
                      if(_response?.tempInfo.temperature != null)
                        Text('${_response!.tempInfo.temperature}°с', style: const TextStyle(
                          fontFamily: 'Arial',
                          fontSize: 60,
                          fontWeight: FontWeight.w600,
                          color: Colors.white
                        )),
                      if(_response?.tempInfo.temperature != null)
                        const Text('-------------', style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontFamily: 'Arial',
                          fontWeight: FontWeight.w600
                        )),
                        if(_response?.weatherInfo.description != null)
                         Text(_response!.weatherInfo.description, style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontFamily: 'Arial',
                          fontWeight: FontWeight.w600
                        )),
                      if(_response?.iconUrl != null)
                        Image.network(_response!.iconUrl),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if(_response?.windInfo.speed != null)
                              const Icon(Icons.air_outlined, color: Colors.white, size: 30),
                            if(_response?.windInfo.speed != null)
                              Text('Wind speed: ${_response?.windInfo.speed} m/s', style: const TextStyle(
                                color: Colors.white,
                                fontFamily: 'Arial',
                                fontSize: 18
                              ))
                          ]
                        )
                    ],
                    ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 35, 5, 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if(_response?.mainInfo.minTemp != null && _response?.mainInfo.maxTemp != null)
                        MiniWeather(
                        icon: Icons.device_thermostat_outlined,
                        day:'Temp',
                        degrees: '${_response?.mainInfo.minTemp}°с / ${_response?.mainInfo.maxTemp}°с',
                        newColor: Colors.redAccent),
                      if(_response?.mainInfo.pressure != null)
                        MiniWeather(
                        icon: Icons.compress_outlined,
                        day:'Pressure',
                        degrees: '${_response?.mainInfo.pressure} hPa',
                        newColor: Colors.grey.shade400),
                      if(_response?.mainInfo.humidity != null)
                        MiniWeather(
                        icon: Icons.water_drop_outlined,
                        day:'Humidity',
                        degrees: '${_response?.mainInfo.humidity} %',
                        newColor: Colors.blue),
                    ],
                  ),
                ),
              ]
              ),
          ),
        ),
      ),
    );
  }

    void _search() async {
    final response = await _dataService.getWeather(_cityTextController.text);
    setState(() => _response = response);
  }
}