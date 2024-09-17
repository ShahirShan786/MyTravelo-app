


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:my_travelo_app/Views/Screens/Main_Screens/Login/Pages/logIn_page.dart';
import 'package:my_travelo_app/Views/Screens/Primary_Screens/Home/pages/home_screens.dart';
import 'package:my_travelo_app/constants/constant.dart';
import 'package:my_travelo_app/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class buildSettingsSection extends StatelessWidget {
  const buildSettingsSection({
    super.key,
    required this.profileScreens,
    required this.icons,
    required this.titles,
  });

  final List<Widget> profileScreens;
  final List<IconData> icons;
  final List<String> titles;

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
