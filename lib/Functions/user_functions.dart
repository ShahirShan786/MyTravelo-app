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
const expenseDbName = "expense-database";
const dreamDestinationDbName = "dream-destinatiion-database";

ValueNotifier<List<TripModel>> tripList = ValueNotifier([]);
ValueNotifier<List<TripModel>> tripListCompleted = ValueNotifier([]);
ValueNotifier<List<PlaceModel>> fevoriteList = ValueNotifier([]);
ValueNotifier<List<CompletedTripModelPhotos>> completedTripListPhotos =
    ValueNotifier([]);
ValueNotifier<List<CompletedTripModelBlog>> completedTripListBlog =
    ValueNotifier([]);
ValueNotifier<List<ExpenseModel>> expenseListener = ValueNotifier([]);
ValueNotifier<List<DreamDestinationModel>> dreamDestinationListener =
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

  // Clear both lists before processing
  tripList.value.clear();
  // tripListCompleted.value.clear();

  for (var element in trip) {
    DateTime now = DateTime.now();
    log("Current Date and time $now");
    DateTime rangeEnd = element.rangeEnd;
    log("Trip end date : $rangeEnd");

    if (rangeEnd.isBefore(now)) {
      // Add to completed trips
      if (!tripListCompleted.value.contains(element)) {
        tripListCompleted.value.add(element);
        log("Added to completed trips: ${element.destination}");
      }
    } else {
      // Add to upcoming trips
      tripList.value.add(element);
      log("Added to upcoming trips: ${element.destination}");
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
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
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
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  completedTripListPhotos.notifyListeners();
}

// to add blogs in database

Future<void> addBlogs({required CompletedTripModelBlog blog}) async {
  log("entered to the blog function ");
  final completedTripModelBox =
      await Hive.openBox<CompletedTripModelBlog>(completedTripDbNameBlogs);
  await completedTripModelBox.put(blog.id, blog);

  completedTripToList();
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
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
          }
        }
      }
    }
  });
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  fevoriteList.notifyListeners();
}
// *****expense fuctions *****

addExpense({required ExpenseModel expenses}) async {
  final expenseBox = await Hive.openBox<ExpenseModel>(expenseDbName);
  await expenseBox.put(expenses.id, expenses);

  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  expenseListener.notifyListeners();
  await getExpenses();
}

Future<List<ExpenseModel>> getExpenses() async {
  final expenseBox = await Hive.openBox<ExpenseModel>(expenseDbName);
  return expenseBox.values.toList();
}

deleteExpense({required ExpenseModel expense}) async {
  final expenseBox = await Hive.openBox<ExpenseModel>(expenseDbName);
  await expenseBox.delete(expense.id);
  getExpenses();
}

expenseToList({required String tripId}) async {
  expenseListener.value.clear();
  final expense = await getExpenses();
  Future.forEach(expense, (element) {
    if (element.tripId == tripId) {
      expenseListener.value.add(element);
    }
  });
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  expenseListener.notifyListeners();
}

// dream destination Hive functions

Future<void> addDreamPlace(
    {required DreamDestinationModel destinationTrip}) async {
  final dreamDestinatinBox =
      await Hive.openBox<DreamDestinationModel>(dreamDestinationDbName);
  await dreamDestinatinBox.put(destinationTrip.id, destinationTrip);
  log("Added place: ${destinationTrip.destination}");
  dreamDestinationListener.notifyListeners();
//  await getDreamPlace();
  await dreamPlaceToList(userId: destinationTrip.userId);
}

Future<List<DreamDestinationModel>> getDreamPlace() async {
  final dreamDestinationBox =
      await Hive.openBox<DreamDestinationModel>(dreamDestinationDbName);
  final places = dreamDestinationBox.values.toList();
  log("Retrieved ${places.length} places from the database");
  return places;
}

deleteDreamPlace({required DreamDestinationModel destination}) async {
  final dreamDestiantionBox =
      await Hive.openBox<DreamDestinationModel>(dreamDestinationDbName);
  log("Before deletion :${dreamDestinationListener.value.length}");
  await dreamDestiantionBox.delete(destination.id);
  log("after deletion :${dreamDestinationListener.value.length}");
  final updatedList = dreamDestiantionBox.values.toList();
  dreamDestinationListener.value = updatedList;
  dreamDestinationListener.notifyListeners();
}

updateDreamPlace({required DreamDestinationModel destination}) async {
  try {
    final dreamDestinationBox =
        await Hive.openBox<DreamDestinationModel>(dreamDestinationDbName);

    if (dreamDestinationBox.containsKey(destination.id)) {
      await dreamDestinationBox.put(destination.id, destination);
    } else {
      log("The destination with id${destination.id}does not exist");
      return;
    }
    log("Dream destination succussfully updated");
    dreamDestinationListener.value = dreamDestinationBox.values.toList();
    dreamDestinationListener.notifyListeners();
  } catch (e) {
    log("fail to update :$e");
  }
}

Future<void> dreamPlaceToList({required String userId}) async {
  dreamDestinationListener.value.clear();
  final dreamPlaces = await getDreamPlace();

  for (var place in dreamPlaces) {
    if (place.userId == userId) {
      log("Adding place: ${place.destination}");
      dreamDestinationListener.value.add(place);
    }
  }

  dreamDestinationListener.notifyListeners();
}

Future<void> addSavigs(
    int index, double amount, DreamDestinationModel destination) async {
  final dreamDestinationBox =
      await Hive.openBox<DreamDestinationModel>(dreamDestinationDbName);
  final newSavings = destination.totalSavings + amount;

  final updatedSaving = DreamDestinationModel(
      id: destination.id,
      userId: destination.userId,
      destination: destination.destination,
      totalExpense: destination.totalExpense,
      totalSavings: newSavings,
      placeImage: destination.placeImage);

  await dreamDestinationBox.putAt(index, updatedSaving);
  dreamDestinationListener.value[index] = updatedSaving;
  dreamDestinationListener.notifyListeners();
  log("Add saving amound updated");
}

// Google map function

void navigateToPlace({required double lat, required double long}) async {
  final Uri googleMapUrl =
      Uri.parse('https://www.google.com/maps/search/?api=1&query=$lat,$long');
  if (await canLaunchUrl(googleMapUrl)) {
    await launchUrl(googleMapUrl);
  } else {
    throw "Could not launch $googleMapUrl";
  }
}
