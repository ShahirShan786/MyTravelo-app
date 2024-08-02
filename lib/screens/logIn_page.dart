import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_travelo_app/Widgets/textFormFeilds.dart';
import 'package:my_travelo_app/constants/constable.dart';
import 'package:my_travelo_app/constants/constant.dart';
import 'package:my_travelo_app/dashboard.dart';

import 'package:my_travelo_app/models/singInModel.dart';
import 'package:my_travelo_app/screens/SingIn_page.dart';
import 'package:my_travelo_app/servies/signIn_service.dart';
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
      body: SafeArea(
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
                          height: 55.w,
                        ),
                        Textformfeilds(
                          borderColor: Colors.red,
                          focusedColor: primaryColor,
                          labelText: "Username",
                          keyboardType: TextInputType.text,
                          labelColor: secondaryColor,
                          controller: _loginUsername,
                       
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter your username";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10.w),
                        Textformfeilds(
                          borderColor: Colors.red,
                          focusedColor: primaryColor,
                          keyboardType: TextInputType.visiblePassword,
                          labelText: "Password",
                          labelColor: secondaryColor,
                          controller: _loginPasssword,
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter the password";
                            }
                            if (value.length < 6) {
                              return "Password must be at least 6 characters long";
                            }
                            return null;
                          },
                        ),
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
                                content: "sing Up",
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SinginPage(),
                                  ));
                            },
                            child: TextWidget(
                                content: "Create Account",
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
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
        prefz.setString("currentuserId", elements.id.toString());
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
          backgroundColor: Colors.green,
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
