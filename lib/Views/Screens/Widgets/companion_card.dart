import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_travelo_app/constants/constable.dart';
import 'package:my_travelo_app/constants/constant.dart';

class CompanionCard extends StatelessWidget {
  String? title;
  IconData? icon;
  final VoidCallback onPressed;
  CompanionCard({
    required this.title,
    required this.icon,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(left: 10.w, right: 10.w),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 60.h,
          child: InkWell(
            onTap: onPressed,
            child: ListTile(
              leading: Padding(
                padding: EdgeInsets.only(
                  top: 5.h,
                ),
                child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 25.sp,
                    child: FaIcon(
                      icon,
                      color: primaryColor,
                      size: 18.w,
                    )),
              ),
              title: Padding(
                padding:   EdgeInsets.only(right: 50.r),
                child: SizedBox(
                  width: 200.w,
                  height: 40.h,
                  child: Center(
                    child: TextWidget(
                        content: title,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
