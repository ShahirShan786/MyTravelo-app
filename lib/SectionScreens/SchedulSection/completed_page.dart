import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_travelo_app/constants/constable.dart';
import 'package:my_travelo_app/constants/constant.dart';

class CompletedPage extends StatelessWidget {
  const CompletedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(10.w),
      child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              color: Colors.green[50],
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 115.h,
                  child: Padding(
                    padding: EdgeInsets.all(8.0.w),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.greenAccent[100],
                          radius: 32.r,
                          child: Icon( 
                            Icons.check_sharp,
                            size: 25.r,
                          ),
                        ),
                        Padding(
                          padding:  EdgeInsets.all(5.w),
                          child: SizedBox(
                            width: 274.w,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 15.h,
                                ),
                                Padding(
                                  padding:  EdgeInsets.only(left: 10.w),
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
                                  padding:  EdgeInsets.only(left: 10.w),
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
                                          icon: Icon(
                                            Icons.delete,
                                            color: primaryColor,
                                          ))
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
