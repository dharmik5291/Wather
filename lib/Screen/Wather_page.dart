import 'package:flutter/material.dart';
import 'package:wather/Model/wather_model.dart';
import 'package:wather/Service/Wather_api.dart';

class WatherPage extends StatefulWidget {
  const WatherPage({Key? key, required this.cityname, required this.temp})
      : super(key: key);
  final String cityname;
  final double temp;

  @override
  State<WatherPage> createState() => _WatherPageState();
}

class _WatherPageState extends State<WatherPage> {
  WeatherApiClient client = WeatherApiClient();
  Weather? data;

  Future<void> getData(BuildContext context) async {
    data = await client.getCurrentWeather(
        location: widget.cityname, context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 230, 225, 225),
      body: FutureBuilder(
        future: getData(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return snapshot.connectionState == ConnectionState.done
              ? Scaffold(
                  body: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/1.jpg"),
                          fit: BoxFit.cover,
                          opacity: 10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30, left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                  Icons.arrow_back,
                                  size: 30,
                                ),
                                color: Colors.black,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                "Weather Api",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 25),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Image.asset(
                            'assets/4.gif',
                            width: 600.0,
                            height: 240.0,
                            fit: BoxFit.cover,
                          ),
                          Center(
                            child: Text(
                              "${data!.cityname}",
                              style: const TextStyle(fontSize: 60),
                            ),
                          ),
                          Center(
                            child: Text(
                              "${data!.temp}°c",
                              style: const TextStyle(fontSize: 65),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              : const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
