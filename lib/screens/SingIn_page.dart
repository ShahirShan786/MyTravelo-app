import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_travelo_app/Widgets/textFormFeilds.dart';
import 'package:my_travelo_app/constants/constable.dart';
import 'package:my_travelo_app/constants/constant.dart';
import 'package:my_travelo_app/models/singInModel.dart';
import 'package:my_travelo_app/screens/logIn_page.dart';
import 'package:my_travelo_app/servies/signIn_service.dart';

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
            // width: double.infinity,
            // height: double.infinity,
            child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(25.w),
            child: Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30.h,
                  ),
                  TextWidget(
                      content: "Welcome",
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w600),
                  TextWidget(
                      color: Colors.black,
                      content: "Create an Account Here!",
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w600),
                  SizedBox(
                    height: 15.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 40.w),
                    child: Image.asset(
                      "assets/logo/logo1.png",
                      width: 250.w,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Textformfeilds(
                    borderColor: Colors.red,
                    focusedColor: primaryColor,
                    controller: usernameController,
                    labelText: "Username",
                    keyboardType: TextInputType.text,
                    labelColor: secondaryColor,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please Enter username";
                      }

                      return null;
                    },
                   

                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Textformfeilds(
                    controller: emailController,
                    labelText: "E-mail",
                    keyboardType: TextInputType.emailAddress,
                    labelColor: secondaryColor,
                    borderColor: Colors.red,
                    focusedColor: primaryColor,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please Enter an Email";
                      }
                      RegExp regex = RegExp(emailPattern);
                      if (!regex.hasMatch(value)) {
                        return "Enter a valid email address";
                      }

                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Textformfeilds(
                    borderColor: Colors.red,
                    focusedColor: primaryColor,
                    controller: phoneController,
                    keyboardType: TextInputType.number,
                    labelText: "Phone",
                    labelColor: secondaryColor,
                    textColor: formkey.currentState?.validate()== false ? red : Colors.black,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "please enter phone number";
                      }
                      if (value.length < 10 || value.length > 10) {
                        return 'Enter a valid phone number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10.w,
                  ),
                  Textformfeilds(
                    borderColor: Colors.red,
                    focusedColor: primaryColor,
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    labelText: "Password",
                    labelColor: secondaryColor,
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
                  SizedBox(
                    height: 50.w,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5.w),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                WidgetStateProperty.all(primaryColor),
                            foregroundColor: WidgetStateProperty.all(white),
                            padding: WidgetStateProperty.all(
                                EdgeInsets.symmetric(
                                    horizontal: 130.w, vertical: 15.h))),
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

                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.green,
                            content: TextWidget(
                                color: Colors.white,
                                content: "Sign in Successfully",
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600),
                          ));
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginPage(),
                              ));
                          }
                         
                          // ignore: use_build_context_synchronously
                         
                        },
                        child: TextWidget(
                            content: "sing Up",
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w600)),
                  )
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }



  // Future<void> showScafoldMessage(BuildContext context) async {
  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //     backgroundColor: red,
  //     content: TextWidget(
  //         color: white,
  //         content: "Please fill this form Section",
  //         fontSize: 15.sp,
  //         fontWeight: FontWeight.w600),
  //   ));
  // }
}


