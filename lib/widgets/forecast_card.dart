import 'package:flutter/material.dart';
import 'package:forecast_app/utilities/forecast_util.dart';

Widget forecastCard(AsyncSnapshot snapshot, int index) {
  var forecastList = snapshot.data.list;
  var dayOfWeek = '';
  DateTime date = DateTime.fromMillisecondsSinceEpoch(forecastList[index].dt * 1000);
  var fullDate = Util.getFormattedDate(date);//получаем полную дату
  dayOfWeek = fullDate.split(',')[0]; // Tue, обрезаем дату до первой запятой
  var tempMin = forecastList[index].temp.min.toStringAsFixed(0);//получаем минимальную температуру 
  var icon = forecastList[index].getIconUrl();//получаем иконку по индексу
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            dayOfWeek,
            style: const TextStyle(fontSize: 25, color: Colors.white),
          ),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '$tempMin °C',
                      style: const TextStyle(
                        fontSize: 30.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Image.network(icon, scale: 1.2, color: Colors.white),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}