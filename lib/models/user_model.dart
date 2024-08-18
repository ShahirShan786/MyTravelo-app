import 'package:hive_flutter/adapters.dart';

part 'user_model.g.dart';

@HiveType(typeId: 2)
class TripModel {
  @HiveField(0)
  String destination;
  @HiveField(1)
  DateTime rangeStart;
  @HiveField(2)
  DateTime rangeEnd;
  @HiveField(3)
  String id;
  @HiveField(4)
  late List<String> companion;
  @HiveField(5)
  late Map<String, List<String>> activities;
  @HiveField(6)
  String time;
  @HiveField(7)
  String userId;
  TripModel(
      {required this.destination,
      required this.rangeStart,
      required this.rangeEnd,
      required this.id,
      required this.companion,
      required this.activities,
      required this.time,
      required this.userId});
}

@HiveType(typeId: 3)
class CompletedTripModelPhotos {
  @HiveField(0)
  final String photos;
  @HiveField(1)
  final String id;
  @HiveField(2)
  final String tripId;

  CompletedTripModelPhotos({
    required this.photos,
    required this.id,
    required this.tripId,
  });
}

@HiveType(typeId: 4)
class CompletedTripModelBlog {
  @HiveField(0)
  final String blog;
  @HiveField(1)
  final String id;
  @HiveField(2)
  final String tripId;

  CompletedTripModelBlog({
    required this.blog,
    required this.id,
    required this.tripId,
  });
}

@HiveType(typeId: 5)
class FevoriteModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String fevoritePlace;
  @HiveField(2)
  final String userId;

  FevoriteModel({
    required this.id,
    required this.fevoritePlace,
    required this.userId,
  });
}
