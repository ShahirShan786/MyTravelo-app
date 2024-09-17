import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget textField(
    {required String label,
    TextEditingController? controller,
    InputBorder boder = const UnderlineInputBorder(),
    int? line,
    String? text,
    Widget? icon,
    TextInputType? keyboard}) {
  if (controller != null && text != null) {
    controller.text = text;
  }
  return TextField(
    keyboardType: keyboard,
    controller: controller,
    maxLines: line,
    decoration: InputDecoration(
      border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(10.r)),
      hintText: label,
      suffixIcon: icon,
    ),
  );
}
