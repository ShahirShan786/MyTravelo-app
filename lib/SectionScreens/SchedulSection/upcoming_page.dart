import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_travelo_app/constants/constant.dart';

class UpcomingPage extends StatelessWidget {
  const UpcomingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.w),
      child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: 3,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              color: Colors.blue[50],
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 115.h,
                  child: Padding(
                    padding: EdgeInsets.all(8.0.w),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 32.r,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 6.h,
                              ),
                              TextWidget(
                                  content: "$index",
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600),
                              TextWidget(
                                  content: "Wed",
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600)
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5.w),
                          child: SizedBox(
                            width: 274.w,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 15.h,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10.w),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextWidget(
                                          content: "Vagamon",
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600),
                                      TextWidget(
                                          content: "04 : 07PM",
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.normal)
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10.w),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextWidget(
                                          content: "19 jun 2024 to 21 jun 2024",
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.normal),
                                      IconButton(
                                          onPressed: () {},
                                          icon: Icon(Icons.edit_note_outlined))
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
            );
          }),
    );
  }
}
