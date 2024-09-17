import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_travelo_app/constants/constable.dart';


class TextFormFeild extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final int? maxLength;
  

  const TextFormFeild(
      {super.key,
      @required this.hintText,
      @required this.controller,
      @required this.validator,
      this.keyboardType,
      this.maxLength});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding:  EdgeInsets.all(8.0.w),
      child: TextFormField(
        maxLines: maxLength,
        controller: controller,
        keyboardType: keyboardType ?? TextInputType.name,
        validator: validator!,
        decoration: InputDecoration(
            hintText: hintText,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide:  BorderSide(color: purple, width: 1.w)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide:  BorderSide(color: primaryColor, width: 2.w))),
      ),
    );
  }
}
