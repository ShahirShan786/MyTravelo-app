import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:my_travelo_app/Views/Screens/Widgets/textFormFeilds.dart';
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
              content: "Delete", fontSize: 22.sp, fontWeight: FontWeight.bold),
          content: TextWidget(
              content: content, fontSize: 14.sp, fontWeight: FontWeight.normal),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Cancel")),
            TextButton(onPressed: onpressed, child: const Text("Delete")),
          ],
        );
      });
}

Future<void> showDeletedDialogue({
  BuildContext? context,
  String? tittle,
  String? contentText,
  String? conformText,
  Function()? onpressed,
}) async {
  Get.defaultDialog(
      title: tittle!,
      titleStyle:
           TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w600, color: black),
      titlePadding: const EdgeInsets.only(right: 165, top: 15),
      content: Padding(
        padding:  EdgeInsets.symmetric(vertical: 15.h),
        child: TextWidget(
            content: conformText, fontSize: 15.sp, fontWeight: FontWeight.w400),
      ),
      actions: [
        Padding(
          padding:  EdgeInsets.only(bottom: 10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text("Cancel")),
              TextButton(onPressed: onpressed, child: const Text("Delete"))
            ],
          ),
        )
      ]);
}

Future<void> showAddSavingDialogue(
    {BuildContext? context,
    Function(double)? onAddSaving,
    double? reminingExpenses}) async {
  double? amount = 0;
  Get.defaultDialog(
      title: "Add Your Savings",
      titlePadding:  EdgeInsets.symmetric(vertical: 15.h),
      titleStyle:  TextStyle(
          fontSize: 22.sp, fontWeight: FontWeight.bold, color: purple),
      contentPadding:  EdgeInsets.all(15.w),
      content: Textformfeilds(
        keyboardType: TextInputType.number,
        labelText: "Add Savings",
        borderColor: red,
        focusedColor: primaryColor,
        controller: TextEditingController(),
        onChanged: (value) {
          amount = double.tryParse(value);
        },
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text("Cancel")),
            TextButton(
                onPressed: () {
                  if (amount! <= reminingExpenses!) {
                    onAddSaving!(amount!);
                    Get.back();
                  } else {
                    ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
                        backgroundColor: red,
                        content: TextWidget(
                          content:
                              "The entered amount exceeds the remainig expense.",
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          color: white,
                        )));
                  }
                },
                child: const Text("Add"))
          ],
        )
      ]);
}

