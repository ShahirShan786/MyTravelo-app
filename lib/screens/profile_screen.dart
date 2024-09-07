import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_travelo_app/Functions/signIn_service.dart';
import 'package:my_travelo_app/Widgets/app_bar.dart';
import 'package:my_travelo_app/Widgets/edit_dialogue.dart';
import 'package:my_travelo_app/constants/constable.dart';
import 'package:my_travelo_app/constants/constant.dart';
import 'package:my_travelo_app/dashboard.dart';
import 'package:my_travelo_app/models/singInModel.dart';
import 'package:my_travelo_app/profileSubScreen/Terms_page.dart';
import 'package:my_travelo_app/profileSubScreen/about_page.dart';
import 'package:my_travelo_app/profileSubScreen/logout_page.dart';
import 'package:my_travelo_app/profileSubScreen/privacy_page.dart';
import 'package:my_travelo_app/screens/home_screens.dart';
import 'package:my_travelo_app/screens/logIn_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profilescreen extends StatefulWidget {
  const Profilescreen({super.key});

  @override
  State<Profilescreen> createState() => _ProfilescreenState();
}

class _ProfilescreenState extends State<Profilescreen> {
  List<Widget> profileScreens = [
    const Aboutpage(),
    const Privacypage(),
    const Termspage(),
    const Logoutpage()
  ];

  List<String> titles = ["About", "Privacy", "Terms", "Log out"];

  List<IconData> icons = [
    Icons.motion_photos_auto,
    Icons.lock,
    Icons.admin_panel_settings_rounded,
    Icons.logout_outlined
  ];

  final Signinservice _signinservice = Signinservice();

  Singinmodel? profileDetail;

  Future<void> _loadProfileData() async {
    SharedPreferences prefz = await SharedPreferences.getInstance();
    final currentUserId = prefz.getString("currentuserId");
    log("recieved currentuderId is :$currentUserId");
    if (currentUserId != null) {
      profileDetail = await _signinservice.getSignInDataById(currentUserId);
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  File? pickedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:const PrimaryAppBar(
        titles: "Profile",
        backgroundColors: BoxColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            children: [
              SizedBox(height: 20.h),
              Container(
                width: double.infinity,
                height: 110.h,
                decoration: BoxDecoration(
                    color: BoxColor, borderRadius: BorderRadius.circular(20.r)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10.w),
                      child: SizedBox(
                        width: 272.w,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    pickedImage = await getImage();
                                    setState(() {});
                                  },
                                  child: ClipOval(
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 40.r,
                                      child: pickedImage != null
                                          ? Image.file(
                                              pickedImage!,
                                              height: 150.h,
                                              width: 150.w,
                                              fit: BoxFit.cover,
                                            )
                                          : (profileDetail != null &&
                                                  profileDetail!.image != null)
                                              ? Image.file(
                                                  File(profileDetail!.image!),
                                                  height: 150.h,
                                                  width: 150.w,
                                                  fit: BoxFit.cover,
                                                )
                                              : Image.network(
                                                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR2ugjmkZZ-tnWNEZKCesBHKSRX2gEeX1zWeE9Iy26eoIrdcWG-oJ_XNvekGTrMbcEdy1M&usqp=CAU"),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 0.w,
                                  bottom: 2.h,
                                  child: Container(
                                    width: 25.w,
                                    height: 25.h,
                                    decoration: const BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle),
                                    child: const Icon(Icons.add),
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 5.h, left: 12.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextWidget(
                                      content: profileDetail != null
                                          ? profileDetail!.username ?? " "
                                          : "User",
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w700),
                                  SizedBox(height: 5.h),
                                  TextWidget(
                                      content: profileDetail != null
                                          ? profileDetail!.email ?? "email"
                                          : "email",
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w500),
                                  const SizedBox(height: 2),
                                  TextWidget(
                                      content: profileDetail != null
                                          ? profileDetail!.phone ?? "phone"
                                          : 'phone',
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400)
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 8.w, top: 10.h),
                      child: IconButton(
                          onPressed: () async {
                            final updatedUser = await showDialog<Singinmodel>(
                              context: context,
                              builder: (context) =>
                                  EditDialogue(user: profileDetail!),
                            );
                            if (updatedUser != null) {
                              setState(() {
                                profileDetail = updatedUser;
                              });
                            }
                          },
                          icon: FaIcon(
                            FontAwesomeIcons.pencil,
                            size: 20.r,
                          )),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20.h),
                width: double.infinity,
                height: 450.w,
                decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(20.r)),
                child: Padding(
                  padding: EdgeInsets.all(8.0.w),
                  child: ListView.builder(
                      itemCount: profileScreens.length,
                      itemBuilder: (BuildContext context, index) {
                        return ListTile(
                          leading: Icon(icons[index]),
                          title: TextWidget(
                              content: titles[index],
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold),
                          trailing:
                              const Icon(Icons.arrow_forward_ios_outlined),
                          onTap: () {
                            if (index == profileScreens.length - 1) {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: TextWidget(
                                          content: "Log out",
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.bold),
                                      content: TextWidget(
                                          content:
                                              "Are you sure you want to logout?",
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w400),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text("Cancel")),
                                        TextButton(
                                          onPressed: () async {
                                            Navigator.of(context)
                                                .pushAndRemoveUntil(
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          const LoginPage(),
                                                    ),
                                                    (Route<dynamic> route) =>
                                                        false);
                                            SharedPreferences prefz =
                                                await SharedPreferences
                                                    .getInstance();
                                            prefz.remove("currentuserId");
                                            log("currentuserId removed");
                                            SharedPreferences prefs =
                                                await SharedPreferences
                                                    .getInstance();
                                            prefs.setBool("isLogedIn", false);
                                            currentScreen = const Homescreen();
                                          },
                                          child: const Text("Log out"),
                                        )
                                      ],
                                    );
                                  });
                            } else {
                              Get.to(
                                () => profileScreens[index],
                              );
                            }
                          },
                        );
                      }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<File?> getImage() async {
    final pickImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickImage != null && profileDetail != null) {
      profileDetail!.image = pickImage.path;
      await _signinservice.updatesignInData(profileDetail!);
      setState(() {
        pickedImage = File(pickImage.path);
      });
      return pickedImage;
    }
    return null;
  }
}
