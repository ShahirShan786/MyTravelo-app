import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_travelo_app/models/user_model.dart';

const tripDbName = "trip-database";

ValueNotifier<List<TripModel>> tripList = ValueNotifier([]);
ValueNotifier<List<TripModel>> tripListCompleted = ValueNotifier([]);

addTrip({required TripModel trip}) async {
  log("Entered the Function");
  final tripBox = await Hive.openBox<TripModel>(tripDbName);
  await tripBox.put(trip.id, trip);

  log("Data Updated..");
  log("Trip length :${tripBox.values.toList().length}");
}

Future<List<TripModel>> getTrip() async {
  final tripBox = await Hive.openBox<TripModel>(tripDbName);
  return tripBox.values.toList();
}

deleteTrip({required TripModel trip}) async {
  final tripBox = await Hive.openBox<TripModel>(tripDbName);
  await tripBox.delete(trip.id);
}
