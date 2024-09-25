import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_travelo_app/Controller/Firebase/firebase_functions.dart';
import 'package:my_travelo_app/Views/Admin-screens/Home_picture/widgets/add_home_picture_button.dart';
import 'package:my_travelo_app/Views/Screens/Widgets/app_bar.dart';
import 'package:my_travelo_app/constants/constable.dart';

class AddHomePictureScreen extends StatefulWidget {
  const AddHomePictureScreen({super.key});

  @override
  State<AddHomePictureScreen> createState() => _AddHomePictureScreenState();
}

class _AddHomePictureScreenState extends State<AddHomePictureScreen> {
  final FireStoreServices fireStoreServices = FireStoreServices();

  List<File?> homePictureList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PrimaryAppBar(
        titles: "Add Home Pictures",
        backgroundColors: BoxColor,
      ),
      body: Padding(
        padding:  EdgeInsets.all(8.0.w),
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            itemCount: homePictureList.length,
            itemBuilder: (BuildContext context, int index) {
              final picture = homePictureList[index];
              return Stack(
                children: [
                  Padding(
                    padding:  EdgeInsets.symmetric(vertical: 5.h),
                    child: SizedBox(
                      height: 230.h,
                      width: double.infinity,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            picture!,
                            fit: BoxFit.cover,
                          )),
                    ),
                  ),
                  Positioned(
                      top: 10.h,
                      right: 10.w,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            homePictureList.removeAt(index);
                          });
                        },
                        child: Container(
                          width: 50.w,
                          height: 50.h,
                          decoration: const BoxDecoration(
                            color: transperant,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.delete_rounded,
                            color: red,
                          ),
                        ),
                      ))
                ],
              );
            }),
      ),
      floatingActionButton: Padding(
        padding:  EdgeInsets.only(bottom: 70.h),
        child: FloatingActionButton(
          onPressed: () => uploadHomePicture(),
          child: const Icon(Icons.add),
        ),
      ),
      bottomSheet: addHomePictureButton(homePictureList: homePictureList, fireStoreServices: fireStoreServices),
    );
  }

  Future<void> uploadHomePicture() async {
    final pickImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickImage != null) {
      setState(() {
        homePictureList.add(File(pickImage.path));
      });
    }
  }
}


