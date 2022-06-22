import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wather/Model/wather_model.dart';
import 'package:wather/Screen/Wather_page.dart';
import 'package:http/http.dart' as http;
import 'package:wather/Service/Wather_api.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeatherApiClient client = WeatherApiClient();
  final _formKey = GlobalKey<FormState>();
  final citynameController = TextEditingController();
  Weather? data;
  bool isbool = true;
  double? temp;
  String? cityName;

  Future<Weather?> getCurrentWeather() async {
    try {
      var endPoint = Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?q=${citynameController.text}&appid=bab281d79e5f1e9755a68d754cc313e7&units=metric");
      var res = await http.get(endPoint);
      var body = jsonDecode(res.body);
      debugPrint(Weather.fromJson(body).cityname);
      cityName = Weather.fromJson(body).cityname;
      temp = Weather.fromJson(body).temp;
      return Weather.fromJson(body);
    } catch (e) {
      setState(() {
        isbool = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Enter Proper city name!'),
      ));
    }
    return null;
  }

  Future<void> getData(BuildContext context) async {
    data = await client.getCurrentWeather(
        location: citynameController.text, context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
          body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/2.jpg"),
          fit: BoxFit.cover,
        )),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            child: Image.asset(
              'assets/3.gif',
              width: 150.0,
              height: 240.0,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: citynameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter Your City';
                }
                return null;
              },
              decoration: InputDecoration(
                fillColor: Color.fromARGB(255, 230, 223, 223),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                filled: true,
                hintStyle: TextStyle(color: Colors.grey[800]),
                hintText: "Enter Your City",
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                getCurrentWeather().whenComplete(
                  () {
                    if (isbool) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WatherPage(
                                  cityname: cityName!, temp: temp!)));
                    } else {
                      isbool = true;
                      setState(() {});
                    }
                  },
                );
              }
            },
            child: const Text(
              'Submit',
              style: TextStyle(
                fontSize: 35,
              ),
            ),
          ),
        ]),
      )),
    );
  }
}
