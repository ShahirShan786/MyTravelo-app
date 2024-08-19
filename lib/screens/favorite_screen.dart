import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_travelo_app/Functions/user_functions.dart';
import 'package:my_travelo_app/SubScreens/place_details_screen.dart';

import 'package:my_travelo_app/constants/constable.dart';
import 'package:my_travelo_app/constants/constant.dart';
import 'package:my_travelo_app/constants/primary_button.dart';
import 'package:my_travelo_app/listes/places_list.dart';
import 'package:my_travelo_app/SubScreens/place_detailes_page.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userRefresh();
  }

  @override
  Widget build(BuildContext context) {
    log("fevoriteList length is : ${fevoriteList.value.length}");

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: TextWidget(
            content: "Saved Trips",
            fontSize: 20.sp,
            fontWeight: FontWeight.bold),
      ),
      body: Padding(
          padding: EdgeInsets.all(10.w),
          child: ValueListenableBuilder(
              valueListenable: fevoriteList,
              builder: (context, value, child) {
                return fevoriteList.value.isNotEmpty
                    ? ListView.builder(
                        itemCount: fevoriteList.value.length,
                        itemBuilder: (BuildContext context, int index) {
                          final fav = fevoriteList.value[index];
                          return InkWell(
                            onTap: () {
                              // Navigator.of(context)
                              //     .push(MaterialPageRoute(builder: (context) {
                              //   return PlaceDetailesPage(
                              //       placeImg: placeList[index].placeImage,
                              //       description: placeList[index].placeDescription,
                              //       place: placeList[index].destination,
                              //       placeName: placeList[index].placename);
                              // }));
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => PlaceDetailsScreen(
                                  index: index,
                                  fav: true,
                                ),
                              ));
                            },
                            child: Card(
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.r)),
                                child: Padding(
                                  padding: EdgeInsets.all(5.w),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15.r),
                                          child: Container(
                                            width: 150,
                                            height: 100,
                                            child: CachedNetworkImage(
                                              imageUrl: fav.subImage[0],
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) =>
                                                  const Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  color: primaryLight,
                                                ),
                                              ),
                                            ),
                                          )),
                                      Padding(
                                        padding: EdgeInsets.all(9.w),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            TextWidget(
                                                content: fav.place,
                                                fontSize: 17.sp,
                                                fontWeight: FontWeight.w600),
                                            SizedBox(
                                              height: 1.h,
                                            ),
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.location_on,
                                                  size: 15,
                                                ),
                                                TextWidget(
                                                    content: fav.district,
                                                    fontSize: 14.sp,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                PrimaryButton(
                                                    backgroundColor:
                                                        primaryColor,
                                                    content: TextWidget(
                                                        content: "Direction",
                                                        fontSize: 10.sp,
                                                        fontWeight:
                                                            FontWeight.normal),
                                                    width: 85.w,
                                                    height: 25.h,
                                                    onPressed: () {
                                                      navigateToPlace(lat: fav.lattitude, long: fav.longitude);
                                                    }),
                                                SizedBox(
                                                  width: 5.sp,
                                                ),
                                                PrimaryButton(
                                                    backgroundColor:
                                                        primaryColor,
                                                    content: TextWidget(
                                                        content: "Remove",
                                                        fontSize: 10.sp,
                                                        fontWeight:
                                                            FontWeight.normal),
                                                    width: 85.w,
                                                    height: 25.h,
                                                    onPressed: () async {
                                                      await removeFevorite(
                                                          fevoritePlace:
                                                              fav.id);
                                                    }),
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        })
                    : const Center(
                        child: Text("No Favorite"),
                      );
              })),
    );
  }
}
