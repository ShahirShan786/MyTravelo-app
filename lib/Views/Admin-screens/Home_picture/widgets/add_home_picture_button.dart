
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_travelo_app/Controller/Firebase/firebase_functions.dart';
import 'package:my_travelo_app/Controller/Hive/image_upload.dart';
import 'package:my_travelo_app/Views/Screens/Widgets/show_dialogues.dart';
import 'package:my_travelo_app/constants/constable.dart';
import 'package:my_travelo_app/constants/constant.dart';
import 'package:my_travelo_app/constants/primary_button.dart';

class addHomePictureButton extends StatelessWidget {
  const addHomePictureButton({
    super.key,
    required this.homePictureList,
    required this.fireStoreServices,
  });

  final List<File?> homePictureList;
  final FireStoreServices fireStoreServices;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70.h,
      color: white,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: PrimaryButton(
            content: TextWidget(
              content: "Add to Homepage",
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
            onPressed: () async {
              if (homePictureList.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      backgroundColor: red,
                      content: TextWidget(
                        content: "Please select the home pictures",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: white,
                      )),
                );
              } else {
                showLoadingDialogue(
                    context: context, content: "Adding data..");
                for (File? image in homePictureList) {
                  if (image != null) {
                    String? imageUrl = await uploadHomeImage(image: image);
    
                    if (imageUrl != null) {
                      await fireStoreServices.addHomepictue(
                          homePics: imageUrl);
                      
                    }
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                  }
                }
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
              }
            },
            height: 50.h,
            width: 250.w,
            backgroundColor: primaryColor,
          ),
        ),
      ),
    );
  }
}
