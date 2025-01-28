import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'permission.dart';

class Location {
  late double latitude;
  late double longitude;
  Permission permission = Permission();

  Future<void> pop({bool? animated}) async {
    await SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop', animated);
  }

  Future<Position> getCurrentLocation() async {
    bool isPermissionGranted = await permission.getLocationPermission();

    if (isPermissionGranted == true) {
      const LocationSettings locationSettings = LocationSettings(
        accuracy: LocationAccuracy.low,
        distanceFilter: 100,
      );
      try {
        Position position = await Geolocator.getCurrentPosition(
            locationSettings: locationSettings);
        latitude = position.latitude;
        longitude = position.longitude;
        return position;
      } catch (e) {
        pop();
        throw const PermissionDeniedException("Permission denied");
      }

    }
    pop();
    throw const PermissionDeniedException("Permission denied");
  }
}