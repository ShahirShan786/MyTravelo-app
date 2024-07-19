import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_travelo_app/SectionScreens/SchedulSection/completed_page.dart';
import 'package:my_travelo_app/SectionScreens/SchedulSection/upcoming_page.dart';
import 'package:my_travelo_app/constants/constable.dart';
import 'package:my_travelo_app/constants/constant.dart';


class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
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
          title: TextWidget(
              content: "My Trips", fontSize: 20.sp, fontWeight: FontWeight.bold),
        ),
        body: const TabBarView(children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Center(
              child: UpcomingPage(),
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Center(
              child: CompletedPage(),
            ),
          )
        ]),
      ),
    );
  }
}
