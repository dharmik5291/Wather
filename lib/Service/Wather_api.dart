import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wather/Model/wather_model.dart';

class WeatherApiClient {
  Future<Weather?> getCurrentWeather(
      {String? location, BuildContext? context}) async {
    try {
      var endPoint = Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?q=$location&appid=bab281d79e5f1e9755a68d754cc313e7&units=metric");

      var res = await http.get(endPoint);
      var body = jsonDecode(res.body);
      debugPrint(Weather.fromJson(body).cityname);
      return Weather.fromJson(body);
    } catch (e) {
      Navigator.of(context!).pop();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Enter Proper city name!'),
      ));
    }
    return null;
  }
}
