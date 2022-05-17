import 'package:flutter/material.dart';

import 'package:forecast_app/api/weather_api.dart';
import 'package:forecast_app/models/weather_forecast_daily.dart';
import 'package:forecast_app/screens/city_screen.dart';
import 'package:forecast_app/widgets/bottom_list_view.dart';
import 'package:forecast_app/widgets/city_view.dart';
import 'package:forecast_app/widgets/detail_view.dart';
import 'package:forecast_app/widgets/temp_view.dart';

class WeatherForecastScreen extends StatefulWidget {
  final WeatherForecast? locationWeather;
  const WeatherForecastScreen({
    Key? key,
    this.locationWeather,
  }) : super(key: key);

  @override
  State<WeatherForecastScreen> createState() => _WeatherForecastScreenState();
}

class _WeatherForecastScreenState extends State<WeatherForecastScreen> {

  late Future<WeatherForecast> forecastObject;
  String _cityName = 'London';

  @override
  void initState() {
    super.initState();

    forecastObject = WeatherApi().fetchWeatherForecast(city: _cityName);
    // if (widget.locationWeather != null) {//если переменная не null
    //   forecastObject = Future.value(widget.locationWeather);//то делаем запрос по геолокации
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: const Text('Weather forecast'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.my_location),
          onPressed: () {
            // setState(() {//по нажатию запрашиваем геолокацию
            //   forecastObject = WeatherApi().fetchWeatherForecast();
            // });
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.location_city),
            onPressed: () async {
              //tappedName хранится наше значение (то что ввели)
              var tappedName = await Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const CityScreen();//по нажатию открываем наш экран CityScreen
              }));
              if (tappedName != null) {//если что-то ввели, то передаем это нашей переменной
                setState(() {
                  _cityName = tappedName;
                  //передаем наш cityName в метод (делаем запрос по названию города)
                  forecastObject = WeatherApi().fetchWeatherForecast(city: _cityName,
                  //  isCity: true
                  );
                });
              }
            },
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          FutureBuilder<WeatherForecast>(
            future: forecastObject,
            builder: (context, snapshot) {
              if (snapshot.hasData) {//если получили данные
                return Column(
                  children: <Widget>[
                    const SizedBox(height: 50.0),
                    CityView(snapshot: snapshot),
                    const SizedBox(height: 50.0),
                    TempView(snapshot: snapshot),
                    const SizedBox(height: 50.0),
                    DetailView(snapshot: snapshot),
                    const SizedBox(height: 50.0),
                    BottomListView(snapshot: snapshot),
                  ],
                );
              } else {
                return const Center(
                  child: Text(
                    'City not found\nPlease, enter correct city',
                    style: TextStyle(fontSize: 25),
                    textAlign: TextAlign.center,
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}