
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_travelo_app/Controller/Firebase/firebase_functions.dart';
import 'package:my_travelo_app/Models/admin_model.dart';
import 'package:my_travelo_app/Views/Admin-screens/admin_place_details_screen.dart';
import 'package:my_travelo_app/constants/constable.dart';
import 'package:my_travelo_app/constants/constant.dart';

class HomePlaceListenableBuilder extends StatelessWidget {
  const HomePlaceListenableBuilder({
    super.key,
    required this.fireStoreServices,
  });

  final FireStoreServices fireStoreServices;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
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
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold),
                        content: TextWidget(
                            content:
                                "Are you sure you want to delete this place?",
                            fontSize: 14.sp,
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
                      height: 145.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.r),
                        child: Image.network(
                          place.mainImage,
                          // loadingBuilder: (context, child, loadingProgress) =>  Center(child: CircularProgressIndicator(color: indicatorColor,)),
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
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding:  EdgeInsets.all(5.r),
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
    );
  }
}