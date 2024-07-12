import 'package:flutter/material.dart';
import 'package:my_travelo_app/SectionScreens/SchedulSection/completed_page.dart';
import 'package:my_travelo_app/SectionScreens/SchedulSection/upcoming_page.dart';
import 'package:my_travelo_app/constants/constable.dart';
import 'package:my_travelo_app/constants/constant.dart';
import 'package:my_travelo_app/constants/primary_button.dart';

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
                  EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              labelColor: Colors.white,
              indicator: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(20)),
              tabs: [
                Tab(
                  child: TextWidget(
                      content: "Upcomming",
                      fontSize: 15,
                      fontWeight: FontWeight.normal),
                ),
                Tab(
                  child: TextWidget(
                      content: "Completed",
                      fontSize: 15,
                      fontWeight: FontWeight.normal),
                ),
              ]),
          centerTitle: true,
          title: TextWidget(
              content: "My Trips", fontSize: 20, fontWeight: FontWeight.bold),
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
