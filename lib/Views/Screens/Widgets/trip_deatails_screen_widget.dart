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
  return Padding(
    padding:  EdgeInsets.all(2.w),
    child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOut,
        width: selectTab == index ? 100.w : 80.w,
        height: 50.h,
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
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    DateFormat('dd MMM').format(date),
                    style: TextStyle(
                        color: white,
                        fontSize: 15.sp,
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
