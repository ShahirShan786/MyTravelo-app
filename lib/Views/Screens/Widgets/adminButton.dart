import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_travelo_app/constants/constable.dart';
import 'package:my_travelo_app/constants/constant.dart';
import 'package:my_travelo_app/Views/Admin-screens/Log_In/Pages/admin_login_screen.dart';

class Adminbutton extends StatelessWidget {
  const Adminbutton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: ScaffoldColor,
            foregroundColor: primaryColor,
            padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 10.h),
            side: const BorderSide(color: primaryColor)),
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => AdminLoginScreen()));
        },
        child: TextWidget(
            content: "Admin?", fontSize: 15.sp, fontWeight: FontWeight.w600));
  }
}
