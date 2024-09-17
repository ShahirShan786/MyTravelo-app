

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_travelo_app/Models/singInModel.dart';
import 'package:my_travelo_app/constants/constant.dart';

class profileInfoSection extends StatelessWidget {
  const profileInfoSection({
    super.key,
    required this.profileDetail,
  });

  final Singinmodel? profileDetail;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 5.h, left: 12.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
              content: profileDetail != null
                  ? profileDetail!.username ?? " "
                  : "User",
              fontSize: 20.sp,
              fontWeight: FontWeight.w700),
          SizedBox(height: 5.h),
          TextWidget(
              content: profileDetail != null
                  ? profileDetail!.email ?? "email"
                  : "email",
              fontSize: 15.sp,
              fontWeight: FontWeight.w500),
           SizedBox(height: 2.h),
          TextWidget(
              content: profileDetail != null
                  ? profileDetail!.phone ?? "phone"
                  : 'phone',
              fontSize: 14.sp,
              fontWeight: FontWeight.w400)
        ],
      ),
    );
  }
}
