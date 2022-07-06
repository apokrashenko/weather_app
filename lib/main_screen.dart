import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/mini_weather.dart';
import 'package:weather_app/data_service.dart';
import 'package:weather_app/weather_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import './utils/constants.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _cityTextController = TextEditingController();

  final _dataService = DataService();

  WeatherResponse? _response;

  final items = <Widget>[
    const Icon(Icons.hourglass_empty_outlined, size: 30),
    const Icon(Icons.home_outlined, size: 30),
    const Icon(Icons.calendar_month_outlined, size: 30)
  ];

  int index = 1;

  final navigationKey = GlobalKey<CurvedNavigationBarState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: accentBackgroundColor,
        appBar: AppBar(
          backgroundColor: appBarBackgroundColor,
          leading: Row(children: [
            const Padding(padding: EdgeInsets.only(left: 5)),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.menu,
                  size: 30,
                  color: iconTextColor,
                ))
          ]),
          title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _cityTextController,
                    style:
                        TextStyle(color: iconTextColor, fontSize: tinyTextSize),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Input the city',
                        hintStyle: TextStyle(
                            color: iconTextColor,
                            fontSize: tinyTextSize,
                            fontWeight: FontWeight.bold)),
                  ),
                )
              ]),
          centerTitle: true, //don't work???
          actions: [
            IconButton(
              onPressed: _search,
              icon: const Icon(Icons.search),
              iconSize: 30,
              color: iconTextColor,
            )
          ],
        ),
        body: SafeArea(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [firstGradientColor, secondGradientColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )),
            child: SingleChildScrollView(
              child: Column(children: [
                const Padding(padding: EdgeInsets.only(top: 25)),
                Column(children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (_response != null)
                        Text(_response!.cityName,
                            style: TextStyle(
                              fontFamily: fontNameTitle,
                              fontSize: mediumTextSize,
                              fontWeight: FontWeight.w500,
                              color: iconTextColor,
                            )),
                      if (_response?.dateTime != null)
                        Text('${_response?.dateTime}',
                            style: TextStyle(
                                color: iconTextColor,
                                fontSize: smallTextSize,
                                fontFamily: fontNameTitle)),
                    ],
                  ),
                ]),
                const Padding(padding: EdgeInsets.only(top: 20)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (_response?.tempInfo.temperature != null)
                      Text('${_response!.tempInfo.temperature}°с',
                          style: TextStyle(
                              fontFamily: fontNameTitle,
                              fontSize: largeTextSize,
                              fontWeight: FontWeight.w600,
                              color: iconTextColor)),
                    if (_response?.tempInfo.temperature != null)
                      Text('-----------------',
                          style: TextStyle(
                              color: iconTextColor,
                              fontSize: tinyTextSize,
                              fontFamily: fontNameTitle,
                              fontWeight: FontWeight.w600)),
                    const Padding(padding: EdgeInsets.only(top: 10)),
                    if (_response?.weatherInfo.description != null)
                      Text(_response!.weatherInfo.description,
                          style: TextStyle(
                              color: iconTextColor,
                              fontSize: tinyTextSize,
                              fontFamily: fontNameTitle,
                              fontWeight: FontWeight.w600)),
                    if (_response?.iconUrl != null)
                      CachedNetworkImage(
                        imageUrl: _response!.iconUrl,
                        progressIndicatorBuilder: (_, url, download) {
                          if (download.progress != null) {
                            final percent = download.progress! * 100;
                            return Text('$percent% done loading',
                                style: TextStyle(
                                    color: iconTextColor,
                                    fontFamily: fontNameTitle,
                                    fontSize: tinyTextSize));
                          }
                          return Text(
                            'Loading...',
                            style: TextStyle(
                                color: iconTextColor,
                                fontFamily: fontNameTitle,
                                fontSize: tinyTextSize),
                          );
                        },
                      ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      if (_response?.windInfo.speed != null)
                        Icon(Icons.air_outlined,
                            color: iconTextColor, size: 30),
                      if (_response?.windInfo.speed != null)
                        Text('Wind speed: ${_response?.windInfo.speed} m/s',
                            style: TextStyle(
                                color: iconTextColor,
                                fontFamily: fontNameTitle,
                                fontSize: tinyTextSize))
                    ])
                  ],
                ),
                const Padding(padding: EdgeInsets.only(top: 30)),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (_response?.mainInfo.minTemp != null &&
                        _response?.mainInfo.maxTemp != null)
                      MiniWeather(
                          icon: Icons.device_thermostat_outlined,
                          day: 'Temp',
                          degrees:
                              '${_response?.mainInfo.minTemp}°с / ${_response?.mainInfo.maxTemp}°с',
                          newColor: tempColor),
                    if (_response?.mainInfo.pressure != null)
                      MiniWeather(
                          icon: Icons.compress_outlined,
                          day: 'Pressure',
                          degrees: '${_response?.mainInfo.pressure} hPa',
                          newColor: pressureColor),
                    if (_response?.mainInfo.humidity != null)
                      MiniWeather(
                          icon: Icons.water_drop_outlined,
                          day: 'Humidity',
                          degrees: '${_response?.mainInfo.humidity} %',
                          newColor: humidityColor),
                  ],
                )
              ]),
            ),
          ),
        ),
        bottomNavigationBar: Theme(
          data: Theme.of(context)
              .copyWith(iconTheme: IconThemeData(color: iconTextColor)),
          child: CurvedNavigationBar(
            key: navigationKey,
            color: bottomNavBarBackgroundColor,
            buttonBackgroundColor: bottomNavBarButtonColor,
            backgroundColor: bottomNavBarButtonBackgroundColor,
            height: 60,
            animationCurve: Curves.ease,
            animationDuration: const Duration(milliseconds: 850),
            index: index,
            items: items,
            onTap: _onTapped,
          ),
        ));
  }

  void _onTapped(index) {
    setState(() {
      this.index = index;
    });
  }

  void _search() async {
    final response = await _dataService.getWeather(_cityTextController.text);
    setState(() => _response = response);
  }
}
