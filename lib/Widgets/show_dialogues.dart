import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_travelo_app/constants/constable.dart';
import 'package:my_travelo_app/constants/constant.dart';

Future<void> showLoadingDialogue({
  required BuildContext context,
  required String content,
}) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(
                color: primaryColor,
              ),
              SizedBox(
                height: 20.h,
              ),
              TextWidget(
                  content: content,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.normal)
            ],
          ),
        );
      });
}

Future<void> showDeleteDialogue({
  required BuildContext context,
  required String content,
  required Function() onpressed,
}) {
  return showDialog(
      context: context,
      builder: (
        context,
      ) {
        return AlertDialog(
          title: TextWidget(
              content: "Delete", fontSize: 22, fontWeight: FontWeight.bold),
          content: TextWidget(
              content: content,
              fontSize: 14,
              fontWeight: FontWeight.normal),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Cancel")),
            TextButton(
                onPressed: onpressed,
                child: const Text("Delete")),
          ],
        );
      });
}
