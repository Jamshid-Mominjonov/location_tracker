import 'package:hive/hive.dart';
import '../models/locationModel.dart';

class HiveService {
  int boxIndex = 1;

  Future<void> saveLocation(LocationModel location, int locationCount) async {
    if (locationCount % 3 == 0 && locationCount != 0) {
      boxIndex++;
      await clearPreviousBoxes(boxIndex - 1);
    }

    final box = await Hive.openBox<LocationModel>('locations_$boxIndex');
    await box.add(location);
  }

  Future<List<LocationModel>> getCurrentLocations() async {
    final box = await Hive.openBox<LocationModel>('locations_$boxIndex');
    return box.values.toList();
  }

  Future<void> clearPreviousBoxes(int maxIndex) async {
    for (int i = 1; i <= maxIndex; i++) {
      final box = await Hive.openBox<LocationModel>('locations_$i');
      await box.clear();
    }
  }

  Future<void> clearAll() async {
    for (int i = 1; i <= boxIndex; i++) {
      final box = await Hive.openBox<LocationModel>('locations_$i');
      await box.clear();
    }
    boxIndex = 1;
  }
}