import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_travelo_app/constants/constable.dart';
import 'package:my_travelo_app/dashboard.dart';
import 'package:my_travelo_app/models/profileModel.dart';
import 'package:my_travelo_app/models/singInModel.dart';
import 'package:my_travelo_app/screens/SingIn_page.dart';


import 'package:my_travelo_app/screens/logIn_page.dart';
import 'package:my_travelo_app/servies/profileServies.dart';
import 'package:my_travelo_app/servies/signInService.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(SinginmodelAdapter());
  await Signinservice().openBox();
  Hive.registerAdapter(ProfilemodelAdapter());
  await Profileservies().openBox();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.green,
          scaffoldBackgroundColor: Colors.white,
          fontFamily: "PrimaryFont",
        ),
        debugShowCheckedModeBanner: false,
        title: "myTravelApp",
        home: FutureBuilder(
          future: CheckUserLogin(),
          builder: (BuildContext contex ,snapshot ){
            if(snapshot.connectionState == ConnectionState.waiting){
              return const CircularProgressIndicator();
            }else{
              return snapshot.data == true ? const Dashboard(userDetails: null,) : const LoginPage();
            }
          },
        ));
  }

  Future<bool> CheckUserLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("isLogedIn") ?? false;
  }

  Future<String?>saveUserName(String username)async{
    SharedPreferences prefsUsername = await SharedPreferences.getInstance();
    await prefsUsername.setString("username", username);
    return null;
  }
}
