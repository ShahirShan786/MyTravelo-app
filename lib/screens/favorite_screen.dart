import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:my_travelo_app/constants/constable.dart';
import 'package:my_travelo_app/constants/constant.dart';
import 'package:my_travelo_app/constants/primary_button.dart';
import 'package:my_travelo_app/listes/places_list.dart';
import 'package:my_travelo_app/SubScreens/place_detailes_page.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
        child: ListView.builder(
            itemCount: placeList.length - 3,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return PlaceDetailesPage(
                        placeImg: placeList[index].placeImage,
                        description: placeList[index].placeDescription,
                        place: placeList[index].destination,
                        placeName: placeList[index].placename);
                  }));
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
                            borderRadius: BorderRadius.circular(15.r),
                            child: Image.network(
                              placeList[index].placeImage,
                              width: 150.w,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(9.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextWidget(
                                    content: placeList[index].placename,
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.w600),
                                SizedBox(
                                  height: 1.h,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      size: 15,
                                    ),
                                    TextWidget(
                                        content: placeList[index].destination,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.normal),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    PrimaryButton(
                                        backgroundColor: primaryColor,
                                        content: TextWidget(
                                            content: "Direction",
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.normal),
                                        width: 85.w,
                                        height: 25.h,
                                        onPressed: () {}),
                                    SizedBox(
                                      width: 5.sp,
                                    ),
                                    PrimaryButton(
                                        backgroundColor: primaryColor,
                                        content: TextWidget(
                                            content: "Remove",
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.normal),
                                        width: 85.w,
                                        height: 25.h,
                                        onPressed: () {}),
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
            }),
      ),
    );
  }
}
