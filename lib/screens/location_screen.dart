import 'package:clouds_app/screens/loading_screen.dart';
import 'package:clouds_app/services/openweather_weather_data.dart';
import 'package:flutter/material.dart';
import 'package:clouds_app/services/location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:clouds_app/services/networking.dart';
import '../services/env.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  double latitude = 48.210033;
  double longitude = 16.363449;
  late String cityName;

  void getCityInformation() async {
 // https://openweathermap.org/api/geocoding-api
    NetworkHelper requestData = NetworkHelper(url: "http://api.openweathermap.org/geo/1.0/direct?q=$cityName&limit=5&appid=${Env.openWeatherApiKey}");
    List<dynamic> openweatherLocationData = await requestData.getLocationData();
    List<CityLocation> cityInformation = requestData.getLocation(openweatherLocationData);

    if (cityInformation.isNotEmpty) {
      latitude = cityInformation[0].lat;
      longitude = cityInformation[0].lon;
    }

    forwardCoordinates();
  }

  void getPhoneLocation() async {
    Position location = await Location().getCurrentLocation();
    latitude = location.latitude;
    longitude = location.longitude;
    forwardCoordinates();
  }

  void forwardCoordinates() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LoadingScreen(latitude: latitude, longitude: longitude );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter a city name',
              ),
              onChanged: (text) {
                cityName = text;
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                elevation: 0,
              ),
              onPressed: () {
                getCityInformation();
              },
              child: const Text("Get city data"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                elevation: 0,
              ),
              onPressed: () {
                getPhoneLocation();
              },
              child: const Text("Get phone location data"),
            ),
          ],
        ),
      ),
    );
  }
}
