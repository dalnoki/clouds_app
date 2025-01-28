import 'package:flutter/material.dart';
import 'package:clouds_app/screens/cloud_main_screen.dart';
import 'package:clouds_app/services/location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:clouds_app/services/networking.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../services/env.dart';


class LoadingScreen extends StatefulWidget {
  final latitude;
  final longitude;

  const LoadingScreen({ required this.latitude, required this.longitude});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  dynamic latitude;
  dynamic longitude;

  @override
  void initState() {
    super.initState();
    longitude = widget.longitude;
    latitude = widget.latitude;
    getWeatherData();
  }

  void getWeatherData() async {
    NetworkHelper requestData = NetworkHelper(url: "https://api.openweathermap.org/data/3.0/onecall?lat=${latitude}&lon=${longitude}&exclude=current,minutely&appid=${Env.openWeatherApiKey}&units=metric");
    Map<String, dynamic> openweatherWeatherData = await requestData.getWeatherData();
    dynamic hourlyData = requestData.getHourlyData(openweatherWeatherData);
    dynamic dailyData = requestData.getDailyData(openweatherWeatherData);

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return CloudMainScreen(hourlyData: hourlyData, dailyData: dailyData );
    }));
  }






  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}