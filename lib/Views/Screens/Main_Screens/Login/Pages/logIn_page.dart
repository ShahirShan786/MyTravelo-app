import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:my_travelo_app/Controller/Hive/signIn_service.dart';
import 'package:my_travelo_app/Views/Screens/Main_Screens/Login/widgets/password_feild.dart';
import 'package:my_travelo_app/Views/Screens/Main_Screens/Login/widgets/username_feild.dart';
import 'package:my_travelo_app/Views/Screens/Widgets/adminButton.dart';
import 'package:my_travelo_app/constants/constable.dart';
import 'package:my_travelo_app/constants/constant.dart';
import 'package:my_travelo_app/dashboard.dart';
import 'package:my_travelo_app/Models/singInModel.dart';
import 'package:my_travelo_app/Views/Screens/Main_Screens/SignIn/Pages/SingIn_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _loginUsername = TextEditingController();
  final TextEditingController _loginPasssword = TextEditingController();
  final _logFormKey = GlobalKey<FormState>();

  final Signinservice _logSignservice = Signinservice();

  List<Singinmodel> getSignData = [];

  // To load sing datas

  Future<void> _loadsignData() async {
    getSignData = await _logSignservice.getsignInData();
    setState(() {});
  }

  @override
  void initState() {
    _loadsignData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final screenWidth = MediaQuery.of(context).size.width;
    // final ScreenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: PreferredSize(
        preferredSize: const Size.fromWidth(600),
        child: SafeArea(
          child: LayoutBuilder(builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                  minWidth: constraints.maxWidth,
                ),
                child: IntrinsicHeight(
                  child: Container(
                    padding: const EdgeInsets.all(25),
                    // width: screenWidth * 1.2,
                    // height: ScreenHeight * 1,
                    child: Form(
                      key: _logFormKey,
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 20.w,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: TextWidget(
                                content: "Let's start your\nJourney together",
                                fontSize: 30.sp,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 20.w,
                          ),
                          Image.asset(
                            "assets/logo/logo1.png",
                            width: 250.w,
                          ),
                          SizedBox(
                            height: 40.w,
                          ),
                         buildLogUsernameFeild(loginUsername: _loginUsername),
                          SizedBox(height: 10.w),
                          buildPasswordFeild(loginPasssword: _loginPasssword),
                          SizedBox(height: 25.w),
                          ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      WidgetStateProperty.all(primaryColor),
                                  foregroundColor:
                                      WidgetStateProperty.all(Colors.white),
                                  padding: WidgetStateProperty.all(
                                      EdgeInsets.symmetric(
                                          horizontal: 140.w, vertical: 14.h))),
                              onPressed: () async {
                                if (_logFormKey.currentState!.validate()) {
                                  setState(() {
                                    logcheck(context);
                                  });
                                }
                              },
                              child: TextWidget(
                                  content: "Log In",
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.w600)),
                          SizedBox(height: 10.h),
                          TextWidget(
                            content: "Don't have an Account ?",
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: secondaryColor,
                          ),
                          SizedBox(height: 20.h),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: primaryColor,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 115.w, vertical: 14.h),
                                  side: const BorderSide(color: primaryColor)),
                              onPressed: () {
                              Get.to(()=> const SinginPage());
                              },
                              child: TextWidget(
                                  content: "Create Account",
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w600)),
                          SizedBox(
                            height: 10.h,
                          ),
                          const Adminbutton()
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Future<void> logcheck(BuildContext context) async {
    final loguser = _loginUsername.text;
    final logpass = _loginPasssword.text;

    bool userFount = false;
    for (var elements in getSignData) {
      if (loguser.isEmpty || logpass.isEmpty) {
        return showScafoldMessage(context);
      }
      if (elements.username == loguser && elements.password == logpass) {
        log("${elements.username}");
        log("${elements.password}");
        SharedPreferences prefz = await SharedPreferences.getInstance();
        prefz.setString(
          "currentuserId",
          elements.id.toString(),
        );
        prefz.setString("currentUserName", elements.username!);
        log("id===${elements.id}");

        _loginUsername.clear();
        _loginPasssword.clear();

        Navigator.push(
            // ignore: use_build_context_synchronously
            context,
            MaterialPageRoute(
              builder: (context) => Dashboard(
                userDetails: elements,
              ),
            ));
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: green,
          content: TextWidget(
              color: Colors.white,
              content: "Loged in Successfully",
              fontSize: 15,
              fontWeight: FontWeight.w600),
        ));
        userFount = true;

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool("isLogedIn", true);

        break;
      }
    }

    if (!userFount) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: TextWidget(
              color: Colors.white,
              content: "Username and password don't match ",
              fontSize: 15.sp,
              fontWeight: FontWeight.w600),
        ),
      );
      _loginUsername.clear();
      _loginPasssword.clear();
      log("Invalid user");
    }
  }

  Future<void> showScafoldMessage(BuildContext context) async {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.red,
      content: TextWidget(
          color: Colors.white,
          content: "Please enter username and password",
          fontSize: 15.sp,
          fontWeight: FontWeight.w600),
    ));
  }
}
