import 'package:hive/hive.dart';

part 'locationModel.g.dart';

@HiveType(typeId: 0)
class LocationModel extends HiveObject {
  @HiveField(0)
  double latitude;

  @HiveField(1)
  double longitude;

  @HiveField(2)
  String address;

  @HiveField(3)
  DateTime time;

  LocationModel({required this.latitude, required this.longitude, required this.address, required this.time});
}