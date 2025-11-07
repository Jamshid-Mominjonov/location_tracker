import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import '../models/locationModel.dart';

class LocationService {
  Future<LocationModel> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
    );

    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    Placemark place = placemarks.first;

    return LocationModel(
      latitude: position.latitude,
      longitude: position.longitude,
      address:
      "${place.locality ?? ''}, ${place.subLocality ?? ''}, ${place.subAdministrativeArea}",
      time: DateTime.now(),
    );
  }

  Future<bool> requestPermission() async {
    final permission = await Geolocator.requestPermission();
    return permission != LocationPermission.denied;
  }
}