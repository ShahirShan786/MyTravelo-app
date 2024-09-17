
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_travelo_app/constants/constable.dart';
import 'package:my_travelo_app/constants/constant.dart';

class AddButton extends StatelessWidget {
  const AddButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.h,
      width: 75.w,
      decoration: BoxDecoration(
          color: primaryColor, borderRadius: BorderRadius.circular(10.r)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextWidget(
            content: "Add",
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: white,
          ),
          Icon(
            Icons.arrow_forward_ios_outlined,
            size: 18.r,
            color: white,
          )
        ],
      ),
    );
  }
}