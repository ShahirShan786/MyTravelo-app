import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_travelo_app/Functions/firebase_functions.dart';
import 'package:my_travelo_app/models/admin_model.dart';
import 'package:my_travelo_app/models/user_model.dart';
import 'package:flutter/src/foundation/change_notifier.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

const tripDbName = "trip-database";
const completedTripDbNamePhotos = "completedTripPhotos-database";
const completedTripDbNameBlogs = "completedTripBlog-database";
const fevoriteDName = "fevoritePlace- database";

ValueNotifier<List<TripModel>> tripList = ValueNotifier([]);
ValueNotifier<List<TripModel>> tripListCompleted = ValueNotifier([]);
ValueNotifier<List<PlaceModel>> fevoriteList = ValueNotifier([]);
ValueNotifier<List<CompletedTripModelPhotos>> completedTripListPhotos =
    ValueNotifier([]);
ValueNotifier<List<CompletedTripModelBlog>> completedTripListBlog =
    ValueNotifier([]);

addTrip({required TripModel trip}) async {
  log("Entered the Function");
  final tripBox = await Hive.openBox<TripModel>(tripDbName);
  await tripBox.put(trip.id, trip);

  log("Data Updated..");
  log("Trip length :${tripBox.values.toList().length}");
  // tripList.value = tripBox.values.toList();
  await splitData(trip.userId);
}

Future<List<TripModel>> getTrip() async {
  SharedPreferences prefz = await SharedPreferences.getInstance();
  final userId = prefz.getString("currentuserId");

  final tripBox = await Hive.openBox<TripModel>(tripDbName);
  // return tripBox.values.toList();
  log("user id :$userId");
  log("--- ${tripBox.values}");
  return tripBox.values.where((trip) => trip.userId == userId).toList();
}

updateTrip({required TripModel trip}) async {
  log("Data enter to the updated function");
  final tripBox = await Hive.openBox<TripModel>(tripDbName);
  return tripBox.put(trip.id, trip);
}

deleteTrip({required TripModel trip}) async {
  final tripBox = await Hive.openBox<TripModel>(tripDbName);
  await tripBox.delete(trip.id);
  log("Trip deleted successfully");
}

Future<void> splitData(String userId) async {
  final trip = await getTrip();

  tripList.value.clear();
  tripListCompleted.value.clear();

  for (var element in trip) {
    DateTime now = DateTime.now();
    log("Current Date and time $now");
    DateTime rangeEnd = element.rangeEnd;
    log("Trip end data : $rangeEnd");

    if (rangeEnd.isBefore(now)) {
      tripListCompleted.value.add(element);
      log("Added to completed trips :${element.destination}");
    } else {
      tripList.value.add(element);
      log("Added to upcomming trips :${element.destination}");
    }
  }

  tripList.value
      .sort((first, second) => first.rangeStart.compareTo(second.rangeStart));
  tripListCompleted.value
      .sort((first, second) => second.rangeStart.compareTo(first.rangeStart));

  log("Upcomming trips Count :${tripList.value.length}");
  log("Completed trips Count :${tripListCompleted.value.length}");
}

// add image to Database

Future<void> addMemmories(
    {required CompletedTripModelPhotos completedTrips}) async {
  log("Date entered to the Image function");
  final completedTripBox =
      await Hive.openBox<CompletedTripModelPhotos>(completedTripDbNamePhotos);
  await completedTripBox.put(completedTrips.id, completedTrips);
  log("Date added successfully");
  await completedTripToList();
  completedTripListPhotos.notifyListeners();
}

Future<List<CompletedTripModelPhotos>> getcompletedTrip() async {
  final completedTripBox =
      await Hive.openBox<CompletedTripModelPhotos>(completedTripDbNamePhotos);
  return completedTripBox.values.toList();
}

Future<void> removeImage(
    {required CompletedTripModelPhotos completedTripImage}) async {
  final completedTripBox =
      await Hive.openBox<CompletedTripModelPhotos>(completedTripDbNamePhotos);
  await completedTripBox.delete(completedTripImage.id);
  log("blog data added successfully");
  await completedTripToList();
}

completedTripToList() async {
  completedTripListPhotos.value.clear();
  final completedTrip = await getcompletedTrip();

  completedTripListPhotos.value = List.from(completedTrip);
  log("---- lenth :${completedTripListPhotos.value.length}");
  completedTripListPhotos.notifyListeners();
}

// to add blogs in database

Future<void> addBlogs({required CompletedTripModelBlog blog}) async {
  log("entered to the blog function ");
  final completedTripModelBox =
      await Hive.openBox<CompletedTripModelBlog>(completedTripDbNameBlogs);
  await completedTripModelBox.put(blog.id, blog);
  log("blog data added successfully");
  completedTripToList();
  completedTripListBlog.notifyListeners();
}

Future<List<CompletedTripModelBlog>> getBlog() async {
  final completedTripModelBox =
      await Hive.openBox<CompletedTripModelBlog>(completedTripDbNameBlogs);
  return completedTripModelBox.values.toList();
}

completedBlogList() async {
  completedTripListBlog.value.clear();

  final completedBlog = await getBlog();
  completedTripListBlog.value = List.from(completedBlog);
}

addFevorite({required FevoriteModel fevoritePlace}) async {
  final fevoriteBox = await Hive.openBox<FevoriteModel>(fevoriteDName);
  await fevoriteBox.put(fevoritePlace.id, fevoritePlace);
  userRefresh();
}

removeFevorite({required String fevoritePlace}) async {
  final fevoriteBox = await Hive.openBox<FevoriteModel>(fevoriteDName);
  await fevoriteBox.delete(fevoritePlace);
  log("Data removed");
 await userRefresh();
}

Future<List<FevoriteModel>> getFevorite() async {
  final fevoriteBox = await Hive.openBox<FevoriteModel>(fevoriteDName);
  return fevoriteBox.values.toList();
}

userRefresh() async {
  fevoriteList.value.clear();
  final fevorite = await getFevorite();
  SharedPreferences prefz = await SharedPreferences.getInstance();
  final currentUserId = prefz.getString("currentuserId");

  Future.forEach(fevorite, (elements) {
    if (currentUserId != null) {
      if (elements.userId == currentUserId) {
        for (PlaceModel place in placeModelListener.value) {
          if (elements.fevoritePlace == place.id) {
            fevoriteList.value.add(place);
            log("fev place added fevorite List");
          }
        }
      }
    }
  });
  fevoriteList.notifyListeners();
}

// Google map function 

void navigateToPlace({required double lat ,required double long}) async {
  final Uri googleMapUrl = Uri.parse('https://www.google.com/maps/search/?api=1&query=$lat,$long');
  if(await canLaunchUrl(googleMapUrl)){
     await launchUrl(googleMapUrl);
  } else{
    throw "Could not launch $googleMapUrl";
  }
}
