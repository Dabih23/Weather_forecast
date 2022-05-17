import 'dart:convert';
import 'dart:developer';
import 'package:forecast_app/models/weather_forecast_daily.dart';
import 'package:forecast_app/utilities/location.dart';
import 'package:http/http.dart' as http;
import 'package:forecast_app/utilities/constants.dart';

class WeatherApi {

   Future<WeatherForecast> fetchWeatherForecast(
     {String? city, }) async {
    var queryParametrs = {
      'appid': Constants.WEATHER_APP_ID,
      'units': 'metric',
      'q': city,
    };

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
