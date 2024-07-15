import 'dart:developer';

import 'package:flutter/material.dart';
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
    TextEditingController _usernameController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    TextEditingController _emailController = TextEditingController();
    TextEditingController _PhoneController = TextEditingController();
    final _formkey = GlobalKey<FormState>();

    Signinservice _signInService = Signinservice();
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Form(
                  key: _formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      TextWidget(
                          content: "Welcome",
                          fontSize: 30,
                          fontWeight: FontWeight.w600),
                      TextWidget(
                          color: Colors.black,
                          content: "Create an Account Here!",
                          fontSize: 30,
                          fontWeight: FontWeight.w600),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40),
                        child: Image.asset(
                          "assets/logo/logo1.png",
                          width: 250,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Textformfeilds(
                        borderColor: Colors.red,
                        focusedColor: primaryColor,
                        controller: _usernameController,
                        labelText: "Username",
                        labelColor: secondaryColor,
                        suffics: const Icon(
                          Icons.check_circle_outline_rounded,
                          color: primaryColor,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Enter username";
                          }

                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Textformfeilds(
                        controller: _emailController,
                        labelText: "E-mail",
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
                      const SizedBox(
                        height: 10,
                      ),
                      Textformfeilds(
                        borderColor: Colors.red,
                        focusedColor: primaryColor,
                        controller: _PhoneController,
                        labelText: "Phone",
                        labelColor: secondaryColor,
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
                      const SizedBox(
                        height: 10,
                      ),
                      // TextFormField(
                      //   controller: _passwordController,
                      //   obscureText: true,
                      //   decoration: const InputDecoration(
                      //     labelText: "Password",
                      //     labelStyle: TextStyle(
                      //         fontSize: 15,
                      //         fontWeight: FontWeight.w600,
                      //         color: secondaryColor),
                      //     enabledBorder: UnderlineInputBorder(
                      //       borderSide: BorderSide(color: Colors.red),
                      //     ),
                      //     focusedBorder: UnderlineInputBorder(
                      //         borderSide:
                      //             BorderSide(color: primaryColor, width: 2)),
                      //     errorBorder: UnderlineInputBorder(
                      //         borderSide: BorderSide(color: primaryColor)),
                      //     focusedErrorBorder: UnderlineInputBorder(
                      //         borderSide: BorderSide(color: primaryColor)),
                      //   ),
                      //   validator: (value) {
                      //     if (value == null || value.isEmpty) {
                      //       return "Please enter the password";
                      //     }
                      //     if (value.length < 6) {
                      //       return "Password must be at least 6 characters long";
                      //     }
                      //     return null;
                      //   },
                      // ),
                      Textformfeilds(
                        borderColor: Colors.red,
                        focusedColor: primaryColor,
                        controller: _passwordController,
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
                      const SizedBox(
                        height: 50,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    WidgetStateProperty.all(primaryColor),
                                foregroundColor:
                                    WidgetStateProperty.all(Colors.white),
                                padding: WidgetStateProperty.all(
                                    const EdgeInsets.symmetric(
                                        horizontal: 130, vertical: 15))),
                            onPressed: () async {
                              final username = _usernameController.text;
                              final password = _passwordController.text;
                              if (_usernameController.text.isEmpty ||
                                  _passwordController.text.isEmpty) {
                                return showScafoldMessage(context);
                              }
                              if (_formkey.currentState!.validate()) {
                                final signData = Singinmodel(
                                  username: username,
                                  password: password,
                                  id: DateTime.now()
                                      .millisecondsSinceEpoch
                                      .toString(),
                                  email: _emailController.text,
                                  phone: _PhoneController.text,
                                );

                                log('signing up');
                                await _signInService.addsignInData(signData);
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LoginPage(),
                                    ));
                              }
                              _usernameController.clear();
                              _passwordController.clear();
                              _emailController.clear();
                              _PhoneController.clear();
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                backgroundColor: Colors.green,
                                content: TextWidget(
                                    color: Colors.white,
                                    content: "Sign in Successfully",
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600),
                              ));
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginPage(),
                                  ));
                            },
                            child: TextWidget(
                                content: "sing Up",
                                fontSize: 17,
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

  Future<void> showScafoldMessage(BuildContext context) async {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.red,
      content: TextWidget(
          color: Colors.white,
          content: "Please fill this form Section",
          fontSize: 15,
          fontWeight: FontWeight.w600),
    ));
  }
}
