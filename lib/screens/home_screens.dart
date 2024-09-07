import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:my_travelo_app/Functions/firebase_functions.dart';
import 'package:my_travelo_app/SubScreens/dream_destination_screen.dart';
import 'package:my_travelo_app/SubScreens/place_details_screen.dart';
import 'package:my_travelo_app/constants/constable.dart';
import 'package:my_travelo_app/constants/constant.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:my_travelo_app/models/admin_model.dart';
import 'package:my_travelo_app/screens/AddTripScreens/add_trip_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  Widget sliderWidget(String urlImage, int index) {
    return Container(
      color: Colors.grey.shade600,
      width: double.infinity,
      child: Image.network(
        urlImage,
        fit: BoxFit.fill,
        width: double.infinity,
      ),
    );
  }

  FireStoreServices fireStoreServices = FireStoreServices();
  @override
  void initState() {
    super.initState();
    fireStoreServices.getFirebaseDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: EdgeInsets.only(left: 10.w),
            child: Center(
              child: TextWidget(
                color: primaryColor,
                content: "MyTravelo",
                fontSize: 19.sp,
                fontWeight: FontWeight.w600,
                fontFamily: "HeaderFont",
              ),
            ),
          ),
          leadingWidth: 120.w,
          actions: [
            IconButton(
                onPressed: () async {
                  SharedPreferences prefz =
                      await SharedPreferences.getInstance();
                  final userId = prefz.getString("currentuserId");
                  Get.to(() => DreamDestinationScreen(
                        userId: userId.toString(),
                      ));
                },
                icon: const Icon(
                  Icons.public,
                  size: 33,
                  color: primaryColor,
                ))
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    CarouselSlider.builder(
                        itemCount: imageItems.length,
                        itemBuilder:
                            (BuildContext context, int index, int realIndex) {
                          final urlImage = imageItems[index];
                          return sliderWidget(urlImage, index);
                        },
                        options: CarouselOptions(
                            height: 350.h,
                            autoPlay: true,
                            viewportFraction: 1.0)),
                    Positioned(
                      bottom: 85,
                      left: 15,
                      child: TextWidget(
                        color: Colors.white,
                        content: "Plan your next  \nadventure",
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w700,
                        fontFamily: "MainFont",
                      ),
                    ),
                    Positioned(
                      bottom: 30,
                      left: 15,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                        ),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const AddTripScreens(),
                          ));
                        },
                        child: TextWidget(
                            color: Colors.white,
                            content: "Create new trip plan",
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: TextWidget(
                      content: "Featured guides from users",
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                    height: 270.w,
                    width: double.infinity,
                    child: ValueListenableBuilder(
                        valueListenable: placeModelListener,
                        builder: (context, value, child) {
                          return placeModelListener.value.isEmpty
                              ? const Center(
                                  child: Text("No places Available"),
                                )
                              : ListView.builder(
                                  // shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: placeModelListener.value.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    PlaceModel place =
                                        placeModelListener.value[index];
                                    return Padding(
                                      padding: const EdgeInsets.all(4),
                                      child: GestureDetector(
                                        onTap: () {
                                          Get.to(
                                            () => PlaceDetailsScreen(
                                              index: index,
                                            ),
                                            transition: Transition.native,
                                          );
                                        },
                                        child: Container(
                                          width: 220.w,
                                          decoration: BoxDecoration(
                                              color: ScaffoldColor,
                                              borderRadius:
                                                  BorderRadius.circular(10.r)),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                height: 160,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.r),
                                                    child: CachedNetworkImage(
                                                      imageUrl:
                                                          place.subImage[0],
                                                      fit: BoxFit.cover,
                                                      placeholder:
                                                          (context, url) =>
                                                              const Center(
                                                        child:
                                                            CircularProgressIndicator(
                                                          color: primaryLight,
                                                        ),
                                                      ),
                                                    )),
                                              ),
                                              SizedBox(
                                                height: 4.h,
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 5.w),
                                                child: TextWidget(
                                                    content: place.place,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                child: Text(
                                                  place.details,
                                                  style: TextStyle(
                                                      fontSize: 13.sp,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 4,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                        }))
              ],
            ),
          ),
        ));
  }
}
