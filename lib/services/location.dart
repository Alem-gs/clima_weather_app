import 'package:geolocator/geolocator.dart';

class Location {
  late double latitudeGeo;
  late double longitudeGeo;

  Future<void> requestPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();
  }

  Future<void> getCrrentLocation() async {
    try {
      final LocationSettings locationSettings = LocationSettings(
        accuracy: LocationAccuracy.low,
        distanceFilter: 100,
      );
      Position position = await Geolocator.getCurrentPosition(
          locationSettings: locationSettings);
      //print(position);
      latitudeGeo = position.latitude;
      longitudeGeo = position.longitude;
    } catch (e) {
      print(e);
    }
  }
}
