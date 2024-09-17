import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_travelo_app/Views/Admin-screens/Log_In/widgets/admin_name_textfield.dart';
import 'package:my_travelo_app/Views/Admin-screens/Log_In/widgets/admin_password_textfield.dart';
import 'package:my_travelo_app/Views/Screens/Widgets/textFormFeilds.dart';
import 'package:my_travelo_app/constants/constable.dart';
import 'package:my_travelo_app/constants/constant.dart';
import 'package:my_travelo_app/constants/primary_button.dart';
import 'package:my_travelo_app/Views/Admin-screens/Home_Page/Pages/admin_home_page.dart';

class AdminLoginScreen extends StatelessWidget {
  AdminLoginScreen({super.key});
  final TextEditingController _adminNameController = TextEditingController();
  final TextEditingController _adminPasswordController =
      TextEditingController();
  final _adminkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:  EdgeInsets.all(8.0.w),
            child: Center(
              child: Form(
                key: _adminkey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: TextWidget(
                        content: "Hello admin !\n    your Welcome",
                        fontSize: 30.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Image.asset(
                      "assets/logo/logo1.png",
                      width: 250.w,
                    ),
                     SizedBox(
                      height: 20.h,
                    ),
                    AdminNameTextField(adminNameController: _adminNameController),
                     SizedBox(
                      height: 15.h,
                    ),
                    AdminPasswordTextField(adminPasswordController: _adminPasswordController),
                     SizedBox(
                      height: 30.h,
                    ),
                    PrimaryButton(
                        backgroundColor: primaryColor,
                        content: TextWidget(
                            content: "Log In",
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold),
                        width: 250.w,
                        height: 50.h,
                        onPressed: () {
                          log("name: ${_adminNameController.text}");
                          log("password : ${_adminPasswordController.text}");
                          if (_adminkey.currentState!.validate()) {
                            final name = _adminNameController.text;
                            final password = _adminPasswordController.text;

                            if (name == "Shahir" && password == "12345") {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const AdminHomePage(),
                              ));
                              showLogSuccessSnackBar(context);
                            } else {
                              shwoLoginFailedSnacbar(context);
                            }
                          }
                        })
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> shwoLoginFailedSnacbar(BuildContext context) async {
    const failMessage = "invalid admin name and password ";
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: primaryColor,
        content: TextWidget(
            content: failMessage, fontSize: 14.sp, fontWeight: FontWeight.bold)));
  }
}





Future<void> showLogSuccessSnackBar(BuildContext context) async {
  const successMessage = "Loged in successfully ";
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: green,
      content: TextWidget(
          content: successMessage, fontSize: 14.sp, fontWeight: FontWeight.bold)));
}
