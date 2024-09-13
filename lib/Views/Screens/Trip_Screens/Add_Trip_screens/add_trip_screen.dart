import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:my_travelo_app/Views/Screens/Widgets/calender_view.dart';
import 'package:my_travelo_app/Views/Screens/Widgets/text_feilds.dart';
import 'package:my_travelo_app/Views/Screens/Widgets/time_picker.dart';
import 'package:my_travelo_app/constants/constable.dart';
import 'package:my_travelo_app/constants/constant.dart';
import 'package:my_travelo_app/constants/primary_button.dart';
import 'package:my_travelo_app/Views/Screens/Trip_Screens/Add_Trip_screens/option_screen.dart';

class AddTripScreens extends StatefulWidget {
  const AddTripScreens({super.key});

  @override
  State<AddTripScreens> createState() => _AddTripScreensState();
}

class _AddTripScreensState extends State<AddTripScreens> {
  TextEditingController destinationController = TextEditingController();
  String? destination;
  DateTime? selectedRangeStart;
  DateTime? selectedRangeEnd;
  String finalSelectTime = "";

  String getTime() {
    return finalSelectTime;
  }

  @override
  Widget build(BuildContext context) {
    // TimeOfDay? selectedTime;
    return Scaffold(
        body: SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned(
                top: 50.h,
                left: 20.w,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[300], shape: BoxShape.circle),
                    width: 40.w,
                    height: 40.h,
                    child: const Icon(Icons.close),
                  ),
                )),
            Center(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 50.h,
                  ),
                  TextWidget(
                      content: "plan a new trip",
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold),
                  SizedBox(
                    height: 30.h,
                  ),
                  SizedBox(
                    child: Padding(
                      padding: EdgeInsets.only(left: 15.w, right: 15.w),
                      child: Column(
                        children: [
                          TextWidget(
                              content: "Build an itinerary and map out your",
                              color: secondaryColor,
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w600),
                          TextWidget(
                              content: "upcoming travel plans",
                              color: secondaryColor,
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w600),
                          SizedBox(
                            height: 15.h,
                          ),
                          TExtFeilds(
                            labelText: "Where to?",
                            hintText: "eg., Munnar, Kodak",
                            controller: destinationController,
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: TextWidget(
                                content: "Pick your Dates and Time",
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700),
                          ),
                          CalenderView(),
                          SizedBox(
                            height: 25.h,
                          ),
                          // Text(finalSelectTime?.format(context).toString());

                          finalSelectTime.isEmpty
                              ? TextWidget(
                                  content: "Time not selected",
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)
                              : TextWidget(
                                  content: "Time is : $finalSelectTime",
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),

                          SizedBox(
                            height: 20.h,
                          ),
                          TimePicker(
                            onTimeSelected: (time) {
                              setState(() {
                                finalSelectTime = time;
                              });
                            },
                          ),
                          SizedBox(
                            height: 25.h,
                          ),
                          PrimaryButton(
                              backgroundColor: primaryColor,
                              content: TextWidget(
                                  content: "Start planning",
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w700),
                              width: 250.w,
                              height: 45.h,
                              onPressed: () {
                                selectedRangeStart = getCalenderRangeStart();
                                selectedRangeEnd = getCalenderRangeEnd();
                                finalSelectTime = getTime();

                                if (selectedRangeStart != null &&
                                    selectedRangeEnd != null &&
                                    finalSelectTime.isNotEmpty &&
                                    destinationController.text.isNotEmpty) {
                                  destination = destinationController.text;
                                  Get.to(
                                      () => OptionScreen(
                                            destination: destination,
                                            selectedRangeEnd: selectedRangeEnd,
                                            selectedRangeStart:
                                                selectedRangeStart,
                                            finalSelectTime: finalSelectTime,
                                          ),
                                      transition:
                                          Transition.rightToLeftWithFade);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Select all feilds..."),
                                      backgroundColor: red,
                                    ),
                                  );
                                }
                              })
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
