import 'package:hive_flutter/adapters.dart';

part 'user_model.g.dart';


@HiveType(typeId: 1)
class TripModel {
  @HiveField(0)
  final String? destination;
  @HiveField(1)
  final DateTime? date;
  @HiveField(2)
  final DateTime rangeStart;
  @HiveField(3)
  final DateTime rangeEnd;
  @HiveField(4)
  final String? uId;
  @HiveField(5)
  final String? companion;
  @HiveField(6)
  final Map<String, List<String>> activities;

  TripModel({
    required this.destination,
    required this.date,
    required this.rangeStart,
    required this.rangeEnd,
    required this.uId,
    required this.companion,
    required this.activities,
  });
}
