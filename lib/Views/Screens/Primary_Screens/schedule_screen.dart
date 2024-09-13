import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:my_travelo_app/constants/constable.dart';
import 'package:my_travelo_app/constants/constant.dart';
import 'package:my_travelo_app/dashboard.dart';
import 'package:my_travelo_app/Views/Screens/Trip_Screens/Completed_Screens/completed_page.dart';
import 'package:my_travelo_app/Views/Screens/Trip_Screens/Upcomming_Screens/upcoming_page.dart';

class ScheduleScreen extends StatelessWidget {
  final String? userId;
  const ScheduleScreen({super.key, this.userId});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: BoxColor,
          bottom: TabBar(
              dividerColor: Colors.white,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorPadding:
                  EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
              labelColor: Colors.white,
              indicator: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(20.r)),
              tabs: [
                Tab(
                  child: TextWidget(
                      content: "Upcomming",
                      fontSize: 15.sp,
                      fontWeight: FontWeight.normal),
                ),
                Tab(
                  child: TextWidget(
                      content: "Completed",
                      fontSize: 15.sp,
                      fontWeight: FontWeight.normal),
                ),
              ]),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Get.to(() => const Dashboard());
              },
              icon: const Icon(Icons.arrow_back)),
          title: TextWidget(
              content: "My Trips",
              fontSize: 20.sp,
              fontWeight: FontWeight.bold),
        ),
        body: TabBarView(children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Center(
                child: UpcomingPage(
              userId: userId.toString(),
            )),
          ),
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Center(
                child: CompletedPage(
              userId: userId.toString(),
            )),
          )
        ]),
      ),
    );
  }
}
