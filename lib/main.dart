import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_travelo_app/Functions/initialisation.dart';
import 'package:my_travelo_app/dashboard.dart';
import 'package:my_travelo_app/screens/logIn_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> main() async {
 
  
  initialisation();
  

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (Context , Widget) => GetMaterialApp(
          theme: ThemeData(
            primaryColor: Colors.green,
            scaffoldBackgroundColor: Colors.white,
            fontFamily: "PrimaryFont",
          ),
          debugShowCheckedModeBanner: false,
          title: "myTravelApp",
          home: FutureBuilder(
            future: checkUserLogin(),
            builder: (BuildContext contex, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else {
                return snapshot.data == true
                    ? const Dashboard()
                    : const LoginPage();
              }
            },
          )),
          designSize:const Size(392.72, 825.45),
    );
  }

  Future<bool> checkUserLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("isLogedIn") ?? false;
  }

  Future<String?> saveUserName(String id) async {
    SharedPreferences prefsUsername = await SharedPreferences.getInstance();
    await prefsUsername.setString("currentuserId",id);
    
    return null;
  }
}
