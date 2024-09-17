import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_travelo_app/Controller/Hive/user_functions.dart';
import 'package:my_travelo_app/Models/admin_model.dart';
import 'package:my_travelo_app/constants/constable.dart';
import 'package:my_travelo_app/constants/constant.dart';
import 'package:my_travelo_app/constants/primary_button.dart';
class buildFavePlaceCard extends StatelessWidget {
  const buildFavePlaceCard({
    super.key,
    required this.fav,
  });

  final PlaceModel fav;

  @override
  Widget build(BuildContext context) {
    return Card(
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
                  child: SizedBox(
                    width: 150.w,
                    height: 100.h,
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
                         Icon(
                          Icons.location_on,
                          size: 15.w,
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
                              navigateToPlace(
                                  lat: fav.lattitude,
                                  long: fav.longitude);
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
    );
  }
}