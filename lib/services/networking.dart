import 'package:http/http.dart' as http;
import 'dart:convert';
import 'openweather_weather_data.dart';

class NetworkHelper {
  late String url;

  NetworkHelper({ required this.url });
// TODO: add retry: https://dart.dev/tutorials/server/fetch-data#make-multiple-requests


  Future<Map<String, dynamic>> getWeatherData() async {
    var convertedUrl = Uri.parse(url);
    final httpResponse = await http.get(convertedUrl);
    if (httpResponse.statusCode != 200) {
      throw Exception("The GET request didn't succeed.");
    }
    final decodedJson = json.decode(httpResponse.body) as Map<String, dynamic>;
    return decodedJson;
  }

  Future<List<dynamic>> getLocationData() async {
    var convertedUrl = Uri.parse(url);
    final httpResponse = await http.get(convertedUrl);
    if (httpResponse.statusCode != 200) {
      throw Exception("The GET request didn't succeed.");
    }
    final decodedJson = json.decode(httpResponse.body);
    print(decodedJson.runtimeType);
    return decodedJson;
  }

  List<dynamic> getHourlyData(Map<String, dynamic> json) {
    final hourlyData = json["hourly"].map((data) => Hourly.fromJson(data)).toList();
    return hourlyData;
  }

  List<dynamic> getDailyData(Map<String, dynamic> json) {
    final dailyData = json["daily"].map((data) => Daily.fromJson(data)).toList();
    return dailyData;
  }

  dynamic getLocation(List<dynamic> json) {
    final locationData = json.map((data) => CityLocation.fromJson(data)).toList();
    return locationData;
  }
}