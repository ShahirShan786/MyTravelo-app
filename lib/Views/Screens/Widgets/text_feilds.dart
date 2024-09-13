import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_travelo_app/constants/constable.dart';

class TExtFeilds extends StatelessWidget {
  String? labelText;
  String? hintText;
  TextEditingController? controller;

  TExtFeilds({super.key, 
    required this.labelText,
    this.hintText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.w),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(
              fontSize: 18.sp, fontWeight: FontWeight.w600, color: Colors.black),
          hintText: hintText,
          hintStyle:TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w400,
              color: secondaryColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
          ),
        ),
      ),
    );
  }
}
