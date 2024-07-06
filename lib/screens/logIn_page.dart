import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_travelo_app/constants/constable.dart';
import 'package:my_travelo_app/constants/constant.dart';
import 'package:my_travelo_app/dashboard.dart';
import 'package:my_travelo_app/models/profileModel.dart';
import 'package:my_travelo_app/models/singInModel.dart';
import 'package:my_travelo_app/screens/SingIn_page.dart';
import 'package:my_travelo_app/servies/signInService.dart';
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
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Form(
                key: _logFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 155),
                      child: TextWidget(
                          content: "Let's start your",
                          fontSize: 30,
                          fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 115),
                      child: TextWidget(
                          color: Colors.black,
                          content: "Journey together!",
                          fontSize: 30,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Image.asset(
                      "assets/logo/logo1.png",
                      width: 250,
                    ),
                    TextFormField(
                      controller: _loginUsername,
                      decoration: const InputDecoration(
                        labelText: "Username",
                        labelStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: secondaryColor),
                        suffixIcon: Icon(
                          Icons.check_circle_outline_outlined,
                          color: primaryColor,
                          size: 22,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: primaryColor, width: 2)),
                        errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: primaryColor)),
                        focusedErrorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: primaryColor)),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _loginPasssword,
                      obscureText: true,
                      decoration: const InputDecoration(
                        
                        labelText: "Password",
                        labelStyle: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: secondaryColor),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: primaryColor, width: 2)),
                        errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: primaryColor)),
                        focusedErrorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: primaryColor)),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                WidgetStateProperty.all(primaryColor),
                            foregroundColor:
                                WidgetStateProperty.all(Colors.white),
                            padding: WidgetStateProperty.all(
                                const EdgeInsets.symmetric(
                                    horizontal: 140, vertical: 14))),
                        onPressed: () async {
                          if (_logFormKey.currentState!.validate()) {
                            setState(() {
                              logcheck(context);
                            });
                          }
                        },
                        child: TextWidget(
                            content: "sing Up",
                            fontSize: 17,
                            fontWeight: FontWeight.w600)),
                    const SizedBox(
                      height: 20,
                    ),
                    TextWidget(
                      content: "Don't have an Account ?",
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: secondaryColor,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: primaryColor,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 115, vertical: 14),
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
                            fontSize: 15,
                            fontWeight: FontWeight.w600))
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
      if( loguser.isEmpty || logpass.isEmpty){
         return  showScafoldMessage(context);
      }
      if (elements.username == loguser && elements.password == logpass) {
        log("${elements.username}");
        log("${elements.password}");

        // add username to profile Database
        Profilemodel(userName: loguser);

        //  store username to sharedpreferences
        SharedPreferences prefsUsername = await SharedPreferences.getInstance();
        prefsUsername.setString("username", loguser);

        _loginUsername.clear();
        _loginPasssword.clear();

        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>  Dashboard(userDetails: elements,),
            ));
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
              fontSize: 15,
              fontWeight: FontWeight.w600),
        ),
      );
      _loginUsername.clear();
      _loginPasssword.clear();
      log("Invalid user");
    }
  }

  Future<void> showScafoldMessage(BuildContext context)async{

   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: TextWidget(
              color: Colors.white,
              content: "Please enter username and password",
              fontSize: 15,
              fontWeight: FontWeight.w600),
        ));

  }
}
