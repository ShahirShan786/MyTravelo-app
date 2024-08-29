import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:my_travelo_app/Functions/firebase_functions.dart';
import 'package:my_travelo_app/constants/constable.dart';
import 'package:my_travelo_app/constants/constant.dart';
import 'package:my_travelo_app/models/admin_model.dart';
import 'package:my_travelo_app/screens/AdminScreens/add_homepicture_screen.dart';
import 'package:my_travelo_app/screens/AdminScreens/admin_addPlace_screen.dart';
import 'package:my_travelo_app/screens/AdminScreens/admin_place_details_screen.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  FireStoreServices fireStoreServices = FireStoreServices();
  List<Map<String, dynamic>> homePictures = [];
  @override
  void initState() {
    super.initState();
    fireStoreServices.getFirebaseDetails();
    _loadHomePictures();
  }

  Future<void> _loadHomePictures() async {
    homePictures = await fireStoreServices.getHomePictures();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: TextWidget(
            content: "Admin Pannel", fontSize: 20, fontWeight: FontWeight.bold),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TextWidget(
              //     content: "Home Pictures",
              //     fontSize: 20,
              //     fontWeight: FontWeight.bold),

              // TextWidget(
              //     content: "Home Pictures",
              //     fontSize: 22,
              //     fontWeight: FontWeight.bold),

              // FutureBuilder<List<Map<String, dynamic>>>(
              //     future: fireStoreServices.getHomePictures(),
              //     builder: (context, snapshot) {
              //       if (snapshot.connectionState == ConnectionState.waiting) {
              //         return const Center(
              //           child: CircularProgressIndicator(),
              //         );
              //       } else if (snapshot.hasError) {
              //         return Center(
              //           child: Text("Erorr:${snapshot.error}"),
              //         );
              //       } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              //         return Center(
              //           child: Text("No image founttt"),
              //         );
              //       }

              //       final List<Map<String, dynamic>> flattenedImages = [];
              //       for (var imageMap in snapshot.data!) {
              //         var urls = imageMap['url'] as List<dynamic>? ?? [];
              //         var docId = imageMap['id']
              //             as String?; // Get the document ID safely
              //         log("=====$docId");
              //         log("***** $urls");
              //         // If docId is null, skip this document to avoid errors
              //         if (docId == null) continue;

              //         for (var url in urls) {
              //           if (url != null) {
              //             flattenedImages.add({
              //               'docId': docId, // Ensure docId is not null
              //               'url': url
              //                   as String, // Ensure url is a non-null String
              //             });
              //           }
              //         }
              //       }

              //       return SizedBox(
              //         height: 253,
              //         child: GridView.builder(
              //             itemCount: flattenedImages.length,
              //             gridDelegate:
              //                 const SliverGridDelegateWithFixedCrossAxisCount(
              //                     crossAxisCount: 2,
              //                     childAspectRatio: 1.5,
              //                     crossAxisSpacing: 5,
              //                     mainAxisSpacing: 5),
              //             itemBuilder: (context, index) {
              //               var imageUrl =
              //                   flattenedImages[index]['url'] as String;

              //               // var docId = flattenedImages[index]['id'] as String;

              //               return ClipRRect(
              //                 borderRadius: BorderRadius.circular(10),
              //                 child: InkWell(
              //                   onTap: () {
              //                     log("${flattenedImages[index]["id"]}");
              //                   },
              //                   onLongPress: () {
              //                     showDialog(
              //                         context: context,
              //                         builder: (
              //                           context,
              //                         ) {
              //                           return AlertDialog(
              //                             title: TextWidget(
              //                                 content: "Delete",
              //                                 fontSize: 22,
              //                                 fontWeight: FontWeight.bold),
              //                             content: TextWidget(
              //                                 content:
              //                                     "Are you sure you want to delete this picture?",
              //                                 fontSize: 14,
              //                                 fontWeight: FontWeight.normal),
              //                             actions: [
              //                               TextButton(
              //                                   onPressed: () {
              //                                     Navigator.of(context).pop();
              //                                   },
              //                                   child: const Text("Cancel")),
              //                               TextButton(
              //                                   onPressed: () async {
              //                                     // ignore: use_build_context_synchronously

              //                                     Navigator.of(context).pop();
              //                                   },
              //                                   child: const Text("Delete")),
              //                             ],
              //                           );
              //                         });
              //                   },
              //                   child: CachedNetworkImage(
              //                     imageUrl: imageUrl,
              //                     fit: BoxFit.fill,
              //                     placeholder: (context, url) => Center(
              //                       child: CircularProgressIndicator(
              //                         color: indicatorColor,
              //                       ),
              //                     ),
              //                     errorWidget: (context, url, error) => Center(
              //                       child: Icon(
              //                         Icons.error_outline,
              //                         color: red,
              //                       ),
              //                     ),
              //                   ),
              //                 ),
              //               );
              //             }),
              //       );
              //     }),

              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 5),
                child: TextWidget(
                    content: "Place Detailes",
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),

              ValueListenableBuilder(
                valueListenable: placeModelListener,
                builder: (context, value, child) {
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: placeModelListener.value.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 5,
                            childAspectRatio: 0.7,
                            crossAxisSpacing: 5),
                    itemBuilder: (context, index) {
                      PlaceModel place = placeModelListener.value[index];
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                AdminPlaceDetailsScreen(index: index),
                          ));
                        },
                        onLongPress: () async {
                          showDialog(
                              context: context,
                              builder: (
                                context,
                              ) {
                                return AlertDialog(
                                  title: TextWidget(
                                      content: "Delete",
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                  content: TextWidget(
                                      content:
                                          "Are you sure you want to delete this place?",
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("Cancel")),
                                    TextButton(
                                        onPressed: () async {
                                          await fireStoreServices.deletePlace(
                                              id: place.id);
                                          // ignore: use_build_context_synchronously
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("Delete")),
                                  ],
                                );
                              });
                        },
                        child: Container(
                          width: 220.w,
                          decoration: BoxDecoration(
                              color: ScaffoldColor,
                              borderRadius: BorderRadius.circular(10.r)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 145,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.r),
                                  child: Image.network(
                                    place.mainImage,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 5.w),
                                child: TextWidget(
                                    content: place.place,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5),
                                child: Text(
                                  place.details,
                                  style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w500),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 4,
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.add_event,
        children: [
          SpeedDialChild(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const AdminAddPlaceScreen(),
                ));
              },
              child: const Icon(Icons.add_photo_alternate_outlined),
              label: "Add Place"),
          SpeedDialChild(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AddHomePictureScreen()));
              },
              child: const Icon(Icons.add_a_photo_outlined),
              label: "Add Home Pictures")
        ],
      ),
    );
  }
}
