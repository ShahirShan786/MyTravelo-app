import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:my_travelo_app/Views/Screens/Widgets/app_bar.dart';
import 'package:my_travelo_app/Views/Screens/Widgets/companion_card.dart';
import 'package:my_travelo_app/constants/constable.dart';
import 'package:my_travelo_app/constants/constant.dart';
import 'package:my_travelo_app/Views/Screens/Trip_Screens/Add_Trip_screens/Companion/Pages/companion_screen.dart';
import 'package:my_travelo_app/Views/Screens/Trip_Screens/Add_Trip_screens/Trip_Plan/Pages/trip_plan_screen.dart';

class OptionScreen extends StatelessWidget {
  final String? destination;
  final DateTime? selectedRangeStart;
  final DateTime? selectedRangeEnd;
  final String finalSelectTime;
  const OptionScreen({
    super.key,
    required this.destination,
    required this.selectedRangeStart,
    required this.selectedRangeEnd,
    required this.finalSelectTime,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PrimaryAppBar(
        titles: "Travel Comapanions",
        backgroundColors: white,
      ),
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.all(10.w),
          child: Column(
            children: [
               SizedBox(
                height: 20.h,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: TextWidget(
                    content: "Select your travel group type",
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500),
              ),
               SizedBox(
                height: 60.h,
              ),
              CompanionCard(
                icon: FontAwesomeIcons.person,
                title: "Solo",
                onPressed: () {
                  Get.to(
                    () => TripPlanScreen(
                      destination: destination,
                      finalSelectTime: finalSelectTime,
                      selectedRangeEnd: selectedRangeEnd,
                      selectedRangeStart: selectedRangeStart,
                    ),
                    transition: Transition.rightToLeft,
                  );
                },
              ),
               SizedBox(
                height: 35.h,
              ),
              CompanionCard(
                icon: FontAwesomeIcons.peopleGroup,
                title: "Companion",
                onPressed: () {
                  Get.to(
                      () => CompanionScreen(
                            destination: destination ?? '',
                            finalSelectTime: finalSelectTime,
                            selectedRangeEnd: selectedRangeEnd!,
                            selectedRangeStart: selectedRangeStart!,
                          ),
                      transition: Transition.rightToLeft);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
