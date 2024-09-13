import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_travelo_app/Models/admin_model.dart';


ValueNotifier<List<PlaceModel>> placeModelListener = ValueNotifier([]);
ValueNotifier<List<HomePictureModel>> homePictureListener = ValueNotifier([]);


class FireStoreServices {
  final CollectionReference places =
      FirebaseFirestore.instance.collection("places");
  final CollectionReference homePicture =
      FirebaseFirestore.instance.collection("homePictures");

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
        double lat = (data["lattitude"] as double?) ?? 0.0;
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
      }
    } catch (e) {
      log("Error geting message from firebase :$e");
    }
  }

  updatePlace(
      {required String id,
      required String place,
      required String district,
      required String details,
      required double lattitude,
      required double longitude,
      required String mainImage,
      required List<String> images}) {
    places.doc(id).update({
      "place": place,
      "district": district,
      "details": details,
      "lattitude": lattitude,
      "longitude": longitude,
      "mainImage": mainImage,
      "subImages": images
    }).then((_) {
      // in here we are updating specific place in the valueNotifier
      int index =
          placeModelListener.value.indexWhere((place) => place.id == id);

      if (index != -1) {
        placeModelListener.value[index] = PlaceModel(
          id: id,
          place: place,
          district: district,
          lattitude: lattitude,
          longitude: longitude,
          details: details,
          mainImage: mainImage,
          subImage: images,
        );
        // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
        placeModelListener.notifyListeners();
      }
    });

    log("===details updated===");
  }

  deletePlace({required String id}) async {
    places.doc(id).delete();
    getFirebaseDetails();
  }

  getFirebaseDetails() async {
    placeModelListener.value.clear();
    homePictureListener.value.clear();
    final FireStoreServices fireStoreServices = FireStoreServices();
    await fireStoreServices.getAllPlaces();

    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    placeModelListener.notifyListeners();
    // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
    homePictureListener.notifyListeners();
  }

  // add home Images to firebase

  addHomepictue({required List<String> homePics}) {
    homePicture.add({
      "homePictures": homePics,
    });
    log("homepic data added");
    getFirebaseDetails();
  }

  Future<List<Map<String, dynamic>>> getHomePictures() async {
    QuerySnapshot querySnapshot = await homePicture.get();

    return querySnapshot.docs
        .map((doc) => {"id": doc.id, "url": doc["homePictures"]})
        .toList();
  }

  Future<void> deleteImage(
      {required String imageId, required String imageUrl}) async {
    DocumentReference docRef = homePicture.doc(imageId);

    DocumentSnapshot docsnapshot = await docRef.get();
    if (docsnapshot.exists) {
      List<dynamic> urls = docsnapshot.get("url");

      urls.remove(imageUrl);

      await docRef.update({'url': urls});
    }
  }



}
