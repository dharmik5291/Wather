class Weather {
  String? cityname;
  double? temp;

  Weather({
    this.cityname,
    this.temp,
  });

  Weather.fromJson(Map<String, dynamic> json) {
    cityname = json["name"];
    temp = json["main"]["temp"];
  }
}
