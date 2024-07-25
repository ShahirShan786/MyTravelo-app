import 'package:contacts_service/contacts_service.dart';
import 'package:hive_flutter/adapters.dart';

part 'user_model.g.dart';

@HiveType(typeId: 2)
class TripModel {
  @HiveField(0)
  final String destination;
  @HiveField(1)
  final DateTime rangeStart;
  @HiveField(2)
  final DateTime rangeEnd;
  @HiveField(3)
  final String id;
  @HiveField(4)
  late List<Contact> companion;
  @HiveField(5)
  final Map<String, List<String>> activities;
  @HiveField(6)
  TripModel({
    required this.destination,
    required this.rangeStart,
    required this.rangeEnd,
    required this.id,
    required this.companion,
    required this.activities,
  });
}
