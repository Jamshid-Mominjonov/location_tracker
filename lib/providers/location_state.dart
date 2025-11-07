import 'package:location_tracker/data/models/locationModel.dart';

abstract class LocationState {}

class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class LocationSuccess extends LocationState {
  final List<LocationModel> locations;

  LocationSuccess(this.locations);
}

class LocationError extends LocationState {
  final String message;
  LocationError(this.message);
}