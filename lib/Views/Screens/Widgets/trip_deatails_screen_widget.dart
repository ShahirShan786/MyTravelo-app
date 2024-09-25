import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_travelo_app/constants/constable.dart';
import 'package:intl/intl.dart';

Widget animatedContainerWidget({
  required selectTab,
  required index,
  required BuildContext context,
  required day,
  required date,
}) {
  final screenHeight = MediaQuery.of(context).size.height;
  final screenWidth = MediaQuery.of(context).size.width;
  return Padding(
    padding: EdgeInsets.all(2.w),
    child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOut,
        width: selectTab == index ? 80.w : 60.w,
        height: 80,
        decoration: BoxDecoration(
            color: selectTab == index ? primaryColor : primaryLight,
            borderRadius: BorderRadius.circular(10.r)),
        child: selectTab == index
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    day,
                    style: TextStyle(
                        color: white,
                        fontSize: screenWidth * 0.01,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    DateFormat('dd MMM').format(date),
                    style: TextStyle(
                        color: white,
                        fontSize: 8.sp,
                        fontWeight: FontWeight.w700),
                  )
                ],
              )
            : Center(
                child: Text(
                  day,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
              )),
  );
}
