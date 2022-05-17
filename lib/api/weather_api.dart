import 'dart:convert';
import 'dart:developer';
import 'package:forecast_app/models/weather_forecast_daily.dart';
import 'package:forecast_app/utilities/location.dart';
import 'package:http/http.dart' as http;
import 'package:forecast_app/utilities/constants.dart';

class WeatherApi {
  // Future<WeatherForecast> fetchWeatherForecast(
  //     {String? city, bool? isCity}) async {
  //   Location location = Location();//получаем локацию
  //   await location.getCurrentLocation();
  //   Map<String, String?> parameters;
   Future<WeatherForecast> fetchWeatherForecast(
     {String? city, }) async {
    var queryParametrs = {
      'appid': Constants.WEATHER_APP_ID,
      'units': 'metric',
      'q': city,
    };

  


    // if (isCity == true) {//если мы передаем определенный город, то выполняем один запрос
    //   var params = {
    //     'appid': Constants.WEATHER_APP_ID,
    //     'units': 'metric',
    //     'q': city
    //   };
    //   parameters = params;
    // } else {
    //   var params = {//иначе передаем город по локации устройства
    //     'appid': Constants.WEATHER_APP_ID,
    //     'units': 'metric',
    //     'lat': location.latitude.toString(),
    //     'lon': location.longitude.toString(),
    //   };
    //   parameters = params;
    // }

    var uri = Uri.https(Constants.WEATHER_BASE_URL_DOMAIN,
        Constants.WEATHER_FORECAST_PATH, queryParametrs);
    log('request: ${uri.toString()}');

    var response = await http.get(uri);

    // print('response: ${response.body}');
    log('response: ${response.body}');

    if (response.statusCode == 200) {
      return WeatherForecast.fromJson(json.decode(response.body));
    } else {
      return Future.error('Error response');
    }
  }
}