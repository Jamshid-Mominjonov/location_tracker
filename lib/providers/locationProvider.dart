import 'dart:async';
import 'package:flutter_riverpod/legacy.dart';
import '../data/services/hiveService.dart';
import '../data/services/locationService.dart';
import 'location_state.dart';

class LocationNotifier extends StateNotifier<LocationState> {
  LocationNotifier({
    required this.locationService,
    required this.hiveService,
  }) : super(LocationInitial());

  final LocationService locationService;
  final HiveService hiveService;

  Timer? timer;
  bool isTracking = false;
  int locationCount = 0;

  Future<void> startGetLocation() async {
    if (isTracking) return;

    try {
      state = LocationLoading();

      bool permissionGranted = await locationService.requestPermission();
      if (!permissionGranted) {
        state = LocationError("Location permission denied");
        return;
      }

      isTracking = true;
      bool isGettingLocation = false;

      timer = Timer.periodic(const Duration(seconds: 10), (timer) async {
        if (!isTracking || isGettingLocation) return;

        isGettingLocation = true;

        try {
          final location = await locationService.getCurrentLocation();
          locationCount++;

          await hiveService.saveLocation(location, locationCount);

          final currentList = await hiveService.getCurrentLocations();
          state = LocationSuccess(List.from(currentList));
        } catch (e) {
          state = LocationError(e.toString());
        }

        isGettingLocation = false;
      });
    } catch (e) {
      state = LocationError(e.toString());
    }
  }

  void stopGetLocation() {
    isTracking = false;
    timer?.cancel();
    state = LocationSuccess([]);
  }

  Future<void> getSavedLocations() async {
    try {
      state = LocationLoading();
      final all = await hiveService.getCurrentLocations();
      state = LocationSuccess(all);
    } catch (e) {
      state = LocationError(e.toString());
    }
  }

  Future<void> clearAllLocations() async {
    try {
      await hiveService.clearAll();
      locationCount = 0;
      state = LocationSuccess([]);
    } catch (e) {
      state = LocationError(e.toString());
    }
  }
}
