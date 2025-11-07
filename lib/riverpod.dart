import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:location_tracker/providers/locationProvider.dart';
import 'package:location_tracker/providers/location_state.dart';
import 'data/services/hiveService.dart';
import 'data/services/locationService.dart';

final locationServiceProvider = Provider<LocationService>((ref) {
  return LocationService();
});

final hiveServiceProvider = Provider<HiveService>((ref) {
  return HiveService();
});

final locationProvider = StateNotifierProvider<LocationNotifier, LocationState>((ref) {
  final locationService = ref.watch(locationServiceProvider);
  final hiveService = ref.watch(hiveServiceProvider);
  return LocationNotifier(
    locationService: locationService,
    hiveService: hiveService,
  );
});
