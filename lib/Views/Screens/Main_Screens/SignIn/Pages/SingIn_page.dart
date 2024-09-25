import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_travelo_app/Controller/Hive/signIn_service.dart';
import 'package:my_travelo_app/Views/Screens/Main_Screens/SignIn/widgets/sign_email_feild.dart';
import 'package:my_travelo_app/Views/Screens/Main_Screens/SignIn/widgets/sign_phone_feild.dart';
import 'package:my_travelo_app/Views/Screens/Main_Screens/SignIn/widgets/sign_username_feild.dart';
import 'package:my_travelo_app/Views/Screens/Main_Screens/SignIn/widgets/sing_password_feild.dart';
import 'package:my_travelo_app/constants/constable.dart';
import 'package:my_travelo_app/constants/constant.dart';
import 'package:my_travelo_app/Models/singInModel.dart';
import 'package:my_travelo_app/Views/Screens/Main_Screens/Login/Pages/logIn_page.dart';

class SinginPage extends StatefulWidget {
  const SinginPage({super.key});

  @override
  State<SinginPage> createState() => _SinginPageState();
}

class _SinginPageState extends State<SinginPage> {
  String emailPattern =
      r'^[a-zA-Z0-9.a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+';

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    final GlobalKey<FormState> formkey = GlobalKey<FormState>();

    Signinservice signInService = Signinservice();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.05, vertical: height * 0.01),
                child: Form(
                  key: formkey,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: TextWidget(
                              content: "Welcome",
                              fontSize: width * 0.03,
                              fontWeight: FontWeight.w600),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: TextWidget(
                              color: Colors.black,
                              content: "Create an Account Here!",
                              fontSize: width * 0.03,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: height * 0.002,
                        ),
                        Image.asset(
                          "assets/logo/logo1.png",
                          width: width * 0.2,
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        buildSignUsernameFeild(
                            usernameController: usernameController),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        BuildSignEmailFeild(
                            emailController: emailController,
                            emailPattern: emailPattern),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 300),
                          child: BuildSignPhoneFeild(phoneController, formkey),
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 300),
                          child: BuildSignPasswordFeild(passwordController),
                        ),
                        SizedBox(
                          height: height * 0.05,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: width * 0.01),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: primaryColor,
                                  foregroundColor: Colors.white,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.090,
                                      vertical: height * 0.01)),
                              onPressed: () async {
                                if (formkey.currentState!.validate()) {
                                  final username = usernameController.text;
                                  final password = passwordController.text;
                                  final signData = Singinmodel(
                                    username: username,
                                    password: password,
                                    id: DateTime.now()
                                        .millisecondsSinceEpoch
                                        .toString(),
                                    email: emailController.text,
                                    phone: phoneController.text,
                                  );

                                  log('signing up');
                                  await signInService.addsignInData(signData);

                                  usernameController.clear();
                                  passwordController.clear();
                                  
                                  emailController.clear();
                                  phoneController.clear();

                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    backgroundColor: Colors.green,
                                    content: TextWidget(
                                        color: Colors.white,
                                        content: "Sign in Successfully",
                                        fontSize: width * 0.016,
                                        fontWeight: FontWeight.w600),
                                  ));
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const LoginPage(),
                                      ));
                                }
                              },
                              child: TextWidget(
                                  content: "Sign Up",
                                  fontSize: width * 0.02,
                                  fontWeight: FontWeight.w600)),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
