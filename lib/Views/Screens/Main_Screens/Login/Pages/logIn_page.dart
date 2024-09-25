import 'dart:developer';

import 'package:flutter/material.dart';
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
import 'package:awesome_dialog/awesome_dialog.dart';

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

  // To load sign-in data
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
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SizedBox(
          width: width,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Form(
                key: _logFormKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: height * 0.02, // Adjusted for responsiveness
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: TextWidget(
                        content: "Let's start your\nJourney together",
                        fontSize: width * 0.03, // Adjusted for responsiveness
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    Image.asset(
                      "assets/logo/logo1.png",
                      width: width * 0.2, // Adjusted for responsiveness
                    ),
                    SizedBox(
                      height: height * 0.02, // Adjusted for responsiveness
                    ),
                    buildLogUsernameFeild(loginUsername: _loginUsername),
                    SizedBox(
                        height: height * 0.01), // Adjusted for responsiveness
                    buildPasswordFeild(loginPasssword: _loginPasssword),
                    SizedBox(
                        height: height * 0.025), // Adjusted for responsiveness
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(primaryColor),
                        foregroundColor: WidgetStateProperty.all(Colors.white),
                        padding: WidgetStateProperty.all(
                          EdgeInsets.symmetric(
                            horizontal:
                                width * 0.090, // Adjusted for responsiveness
                            vertical:
                                height * 0.01, // Adjusted for responsiveness
                          ),
                        ),
                      ),
                      onPressed: () async {
                        if (_logFormKey.currentState!.validate()) {
                          setState(() {
                            logcheck(context);
                          });
                        }
                      },
                      child: TextWidget(
                        content: "Log In",
                        fontSize: width * 0.02, // Adjusted for responsiveness
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                        height: height * 0.01), // Adjusted for responsiveness
                    TextWidget(
                      content: "Don't have an Account?",
                      fontSize: width * 0.01, // Adjusted for responsiveness
                      fontWeight: FontWeight.w600,
                      color: secondaryColor,
                    ),
                    SizedBox(
                        height: height * 0.02), // Adjusted for responsiveness
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: primaryColor,
                        padding: EdgeInsets.symmetric(
                          horizontal:
                              width * 0.045, // Adjusted for responsiveness
                          vertical:
                              height * 0.01, // Adjusted for responsiveness
                        ),
                        side: const BorderSide(color: primaryColor),
                      ),
                      onPressed: () {
                        Get.to(() => const SinginPage());
                      },
                      child: TextWidget(
                        content: "Create Account",
                        fontSize: width * 0.02, // Adjusted for responsiveness
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02, // Adjusted for responsiveness
                    ),
                    const Adminbutton()
                  ],
                ),
              ),
            ),
          ),
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
          ),
        );

        // ignore: use_build_context_synchronously
        showSuccessDialog(context);

        userFount = true;

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool("isLogedIn", true);

        break;
      }
    }

    if (!userFount) {
      showInvalidDialog(context);
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
        fontSize: MediaQuery.of(context).size.width *
            0.04, // Adjusted for responsiveness
        fontWeight: FontWeight.w600,
      ),
    ));
  }

  void showSuccessDialog(BuildContext context) {
    AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.topSlide,
            headerAnimationLoop: false,
            showCloseIcon: false,
            title: "Login Successful",
            desc: 'Welcome! You have successfully logged in.',
            btnOkText: "Continue",
            btnOkOnPress: () {},
            btnOkColor: Colors.green)
        .show();
  }

  void showInvalidDialog(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.rightSlide,
      title: 'Login Failed',
      desc: 'Invalid username or password. Please try again.',
      btnOkText: "Retry",
      btnOkColor: red,
      btnOkOnPress: () {},
    ).show();
  }
}
