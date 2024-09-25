import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_travelo_app/constants/constable.dart';
import 'package:my_travelo_app/dashboard.dart';
import 'package:my_travelo_app/Views/Screens/Trip_Screens/Completed_Screens/completed_page.dart';
import 'package:my_travelo_app/Views/Screens/Trip_Screens/Upcomming_Screens/upcoming_page.dart';

class ScheduleScreen extends StatelessWidget {
  final String? userId;
  const ScheduleScreen({super.key, this.userId});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: BoxColor,
          bottom: TabBar(
            dividerColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorPadding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.05,
              vertical: screenHeight * 0.01,
            ),
            labelColor: Colors.white,
            indicator: BoxDecoration(
              shape: BoxShape.rectangle,
              color: primaryColor,
              borderRadius: BorderRadius.circular(screenHeight * 0.02),
            ),
            tabs: [
              Tab(
                child: Text(
                  "Upcoming",
                  style: TextStyle(
                    fontSize: screenWidth * 0.02, // Adjust font size
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  "Completed",
                  style: TextStyle(
                    fontSize: screenWidth * 0.02, // Adjust font size
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Get.to(() => const Dashboard());
            },
            icon: const Icon(Icons.arrow_back),
          ),
          title: Text(
            "My Trips",
            style: TextStyle(
              fontSize: screenWidth * 0.02, // Adjust font size
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: TabBarView(children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Center(
              child: UpcomingPage(userId: userId.toString()),
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Center(
              child: CompletedPage(userId: userId.toString()),
            ),
          )
        ]),
      ),
    );
  }
}
