import 'package:flutter/material.dart';
import 'package:my_travelo_app/constants/constable.dart';
import 'package:my_travelo_app/constants/constant.dart';
import 'package:my_travelo_app/Views/Admin-screens/Log_In/Pages/admin_login_screen.dart';

class Adminbutton extends StatelessWidget {
  const Adminbutton({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: ScaffoldColor,
            foregroundColor: primaryColor,
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.040, vertical: height * 0.001),
            side: const BorderSide(color: primaryColor)),
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => AdminLoginScreen()));
        },
        child: TextWidget(
            content: "Admin?",
            fontSize: width * 0.015,
            fontWeight: FontWeight.w600));
  }
}
