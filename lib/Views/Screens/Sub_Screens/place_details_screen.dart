import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_travelo_app/Controller/Firebase/firebase_functions.dart';
import 'package:my_travelo_app/Controller/Hive/user_functions.dart';
import 'package:my_travelo_app/Views/Screens/Widgets/details_page_image.dart';
import 'package:my_travelo_app/constants/constable.dart';
import 'package:my_travelo_app/constants/constant.dart';
import 'package:my_travelo_app/constants/primary_button.dart';

class PlaceDetailsScreen extends StatelessWidget {
  final int index;
  final bool fav;

  const PlaceDetailsScreen({super.key, required this.index, this.fav= false});

  @override
  Widget build(BuildContext context) {
    final place = fav ? fevoriteList.value[index] :  placeModelListener.value[index];
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DetailsPageImage(
            place: place,
            context: context,
            isActive: true,
          ),
          Padding(
            padding:  EdgeInsets.all(10.w),
            child: TextWidget(
                content: place.place,
                fontSize: 25.sp,
                fontWeight: FontWeight.bold),
          ),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 10.w),
            child: Row(
              children: [
                Icon(
                  Icons.location_on,
                  size: 20.w,
                  color: secondaryColor,
                ),
                TextWidget(
                    content: place.district,
                    fontSize: 16.sp,
                    color: secondaryColor,
                    fontWeight: FontWeight.normal),
              ],
            ),
          ),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            child: SizedBox(
              width: double.infinity,
              height: 230.h,
              child: SingleChildScrollView(
                child: SizedBox(
                  child: Text(
                    place.details,
                    maxLines: 30,
                    style:  TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      bottomSheet: Container(
        width: double.infinity,
        height: 70.h,
        color: ScaffoldColor,
        child: Center(
            child: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: PrimaryButton(
            content: TextWidget(
                content: "Go to Direction",
                fontSize: 18.sp,
                fontWeight: FontWeight.w600),
            onPressed: () {
                  navigateToPlace(lat: place.lattitude, long: place.longitude);
            },
            height: 50.h,
            width: 250.w,
            backgroundColor: primaryColor,
          ), 
        )),
      ),
    );
  }
}
