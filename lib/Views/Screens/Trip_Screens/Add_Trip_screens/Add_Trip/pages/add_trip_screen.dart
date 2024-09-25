import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_travelo_app/Views/Screens/Trip_Screens/Add_Trip_screens/Trip_Plan/Pages/trip_plan_screen.dart';
import 'package:my_travelo_app/Views/Screens/Widgets/calender_view.dart';
import 'package:my_travelo_app/Views/Screens/Widgets/text_feilds.dart';
import 'package:my_travelo_app/Views/Screens/Widgets/time_picker.dart';
import 'package:my_travelo_app/constants/constable.dart';
import 'package:my_travelo_app/constants/constant.dart';
import 'package:my_travelo_app/constants/primary_button.dart';

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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        body: SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned(
                top: screenHeight * 0.06,
                left: screenWidth * 0.05,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[300], shape: BoxShape.circle),
                    width: screenWidth * 0.1,
                    height: screenHeight * 0.05, 
                    child: const Icon(Icons.close),
                  ),
                )),
            Center(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: screenHeight * 0.06, 
                  ),
                  TextWidget(
                    content: "Plan a new trip",
                    fontSize: screenWidth * 0.025, 
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: screenHeight * 0.03, 
                  ),
                  SizedBox(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.05, 
                      ),
                      child: Column(
                        children: [
                          TextWidget(
                              content: "Build an itinerary and map out your",
                              color: secondaryColor,
                              fontSize: screenWidth * 0.020, 
                              fontWeight: FontWeight.w600),
                          TextWidget(
                              content: "upcoming travel plans",
                              color: secondaryColor,
                              fontSize: screenWidth * 0.020, 
                              fontWeight: FontWeight.w600),
                          TExtFeilds(
                            labelText: "Where to?",
                            hintText: "e.g., Munnar, Kodak",
                            controller: destinationController,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: TextWidget(
                              content: "Pick your Dates and Time",
                              fontSize: screenWidth * 0.02, 
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          CalenderView(),
                          SizedBox(
                            height: screenHeight * 0.01,
                          ),
                          finalSelectTime.isEmpty
                              ? TextWidget(
                                  content: "Time not selected",
                                  fontSize:
                                      screenWidth * 0.01500, 
                                  fontWeight: FontWeight.bold)
                              : TextWidget(
                                  content: "Time is : $finalSelectTime",
                                  fontSize:
                                      screenWidth * 0.01500, 
                                  fontWeight: FontWeight.bold),
                          SizedBox(
                            height: screenHeight * 0.020, 
                          ),
                          TimePicker(
                            onTimeSelected: (time) {
                              setState(() {
                                finalSelectTime = time;
                              });
                            },
                          ),
                          SizedBox(
                            height: screenHeight * 0.03, 
                          ),
                          PrimaryButton(
                              backgroundColor: primaryColor,
                              content: TextWidget(
                                  content: "Start Planning",
                                  fontSize:
                                      screenWidth * 0.025, 
                                  fontWeight: FontWeight.w700),
                              width: screenWidth *
                                  0.090, 
                              height: screenHeight *
                                  0.01, 
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
                                      () => TripPlanScreen(
                                            destination: destination,
                                            selectedRangeStart:
                                                selectedRangeStart,
                                            selectedRangeEnd: selectedRangeEnd,
                                            finalSelectTime: finalSelectTime,
                                          ),
                                      transition:
                                          Transition.rightToLeftWithFade);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text("Please select all fields..."),
                                      backgroundColor: red,
                                    ),
                                  );
                                }
                              }),
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
