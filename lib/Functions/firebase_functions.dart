import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_travelo_app/models/admin_model.dart';

ValueNotifier<List<PlaceModel>> placeModelListener = ValueNotifier([]);

class FireStoreServices {
  final CollectionReference places =
      FirebaseFirestore.instance.collection("places");

  addPlace({
    required String place,
    required String district,
    required String details,
    required double lattitude,
    required double longitude,
    required String mainImage,
    required List<String> subImages,
  }) {
    places.add({
      "place": place,
      "district": district,
      "details": details,
      "lattitude": lattitude,
      "longitude": longitude,
      "mainImage": mainImage,
      "subImages": subImages
    });
    log("data Added..");
    getFirebaseDetails();
  }

  getAllPlaces() async {
    try {
      QuerySnapshot querySnapshot = await places.get();

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        String mainImage = (data["mainImage"] as String);
        List<String> subImages =
            (data["subImages"] as List<dynamic>).cast<String>();
        String documentId = doc.id;
        double lat = (data["lattitude"] as double? ) ?? 0.0;
        double long = (data["longitude"] as double?) ?? 0.0;
        PlaceModel firebasePlaces = PlaceModel(
          id: documentId,
          place: data["place"] ?? "no",
          district: data["district"] ?? "no",
          details: data["details"] ?? "no",
          lattitude: lat,
          longitude: long,
          mainImage: mainImage,
          subImage: subImages,
        );

        placeModelListener.value.add(firebasePlaces);
        

        log("placeModelListeners length :${placeModelListener.value.length}");
      }
    } catch (e) {
      log("Error geting message from firebase :$e");
    }
  }

  deletePlace({required String id}) async {
    places.doc(id).delete();
    getFirebaseDetails();
  }

  getFirebaseDetails() async {
    placeModelListener.value.clear();
    final FireStoreServices fireStoreServices = FireStoreServices();
    await fireStoreServices.getAllPlaces();
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    placeModelListener.notifyListeners();
  }
}
