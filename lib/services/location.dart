import 'package:geolocator/geolocator.dart';

class Location {
  double? latitude;
  double? longitude;

  Future<void> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print('Location services are disabled');
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Location permission denied');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print('Location permission permanently denied');
      return;
    }

    Position? position = await Geolocator.getLastKnownPosition();

    if (position != null) {
      latitude = position.latitude;
      longitude = position.longitude;
      print('Latitude: $latitude');
      print('Longitude: $longitude');
    } else {
      print('No last known location available');
    }
  }
}
