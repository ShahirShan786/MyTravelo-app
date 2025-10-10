import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:MyTravelo/constants/constable.dart';
import 'package:MyTravelo/constants/constant.dart';
import 'package:MyTravelo/Views/Admin-screens/Log_In/Pages/admin_login_screen.dart';

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
