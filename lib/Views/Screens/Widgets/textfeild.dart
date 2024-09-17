import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_travelo_app/constants/constable.dart';

Widget newTextFeild({
  required String labelText,
  required TextEditingController controller,
  required TextInputType keyboardType,
  final String? Function(String?)? validator,
}) {
  return Padding(
    padding:  EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
    child: TextFormField(
      keyboardType: keyboardType,
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
            fontSize: 15.sp, fontWeight: FontWeight.bold, color: Colors.grey[700]),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide:  BorderSide(color: purple, width: 2.w)),
      ),
      validator: validator,
    ),
  );
}
