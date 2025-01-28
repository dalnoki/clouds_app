import 'package:geolocator/geolocator.dart';

class Permission {
  // TODO: exit app if permission is denied
  Future<bool> getLocationPermission() async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        // Handle denied permissions
        print("Location permission denied");
        return false;
      }
    } catch (e) {
      print("Error getting location: $e");
      return false;
    }
    return true;
  }
}


