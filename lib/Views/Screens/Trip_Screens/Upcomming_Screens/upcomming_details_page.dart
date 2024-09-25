import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_travelo_app/Views/Screens/Widgets/app_bar.dart';
import 'package:my_travelo_app/Views/Screens/Widgets/companion_box.dart';
import 'package:my_travelo_app/Views/Screens/Widgets/edit_plan_dialogue.dart';
import 'package:my_travelo_app/Views/Screens/Widgets/trip_deatails_screen_widget.dart';
import 'package:my_travelo_app/constants/constable.dart';
import 'package:my_travelo_app/constants/constant.dart';
import 'package:my_travelo_app/Models/user_model.dart';
import 'package:my_travelo_app/Views/Screens/Trip_Screens/Upcomming_Screens/expense_screen.dart';
import 'package:my_travelo_app/Views/Screens/Trip_Screens/Add_Trip_screens/Trip_Plan/Pages/trip_plan_screen.dart';

class UpcommingDetailsPage extends StatefulWidget {
  final TripModel trip;

  const UpcommingDetailsPage({super.key, required this.trip});

  @override
  State<UpcommingDetailsPage> createState() => _UpcommingDetailsPageState();
}

class _UpcommingDetailsPageState extends State<UpcommingDetailsPage> {
  int selectTab = 0;
  late TripModel trip;

  @override
  void initState() {
    trip = widget.trip;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TripModel trip = widget.trip;
    Map<String, List<String>> activities = trip.activities;
    final dateStart = DateFormat("dd MMM yyyy").format(trip.rangeStart);
    final List<String> companions = trip.companion!;
    List<DateTime> days = getDaysInRange(trip.rangeStart, trip.rangeEnd);

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: PrimaryAppBar(
        backgroundColors: white,
        actions: [expensePageButton(trip)],
      ),
      body: Center(
          child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.02, vertical: screenHeight * 0.01),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
              child: Card(
                elevation: 10,
                child: Container(
                  width: double.infinity,
                  height: screenHeight * 0.15,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(height: screenHeight * 0.01),
                        TextWidget(
                            content: trip.destination,
                            fontSize: screenWidth * 0.02,
                            fontWeight: FontWeight.bold),
                        SizedBox(height: screenHeight * 0.015),
                        TextWidget(
                            content: "Started on $dateStart",
                            fontSize: screenWidth * 0.018,
                            fontWeight: FontWeight.w600),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            companions.isNotEmpty
                ? CompanionBox(
                    companion: companions,
                    trip: trip,
                  )
                : const SizedBox(),
            TextWidget(
                content: "Your plans are",
                fontSize: screenWidth * 0.03,
                fontWeight: FontWeight.w700),
            SizedBox(height: screenHeight * 0.005),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (int i = 0; i < days.length; i++)
                    tabContainer(
                        context: context,
                        day: "Day ${i + 1}",
                        index: i,
                        date: days[i]),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: activities["Day ${selectTab + 1}"]?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    List<String>? plans = activities["Day ${selectTab + 1}"];
                    return Card(
                      child: ListTile(
                        leading: Container(
                          height: screenHeight * 0.03,
                          width: screenWidth * 0.07,
                          decoration: const BoxDecoration(
                              color: white, shape: BoxShape.circle),
                          child: Center(child: Text("${index + 1}")),
                        ),
                        title: Text(plans![index]),
                        trailing: IconButton(
                            onPressed: () {
                              setState(() {
                                activities["Day ${selectTab + 1}"]
                                    ?.remove(plans[index]);
                              });
                            },
                            icon: const Icon(Icons.remove)),
                      ),
                    );
                  }),
            )
          ],
        ),
      )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        foregroundColor: white,
        onPressed: () {
          EditPlanDialogue(
            context: context,
            addplan: (newPlan) {
              setState(() {
                activities["Day ${selectTab + 1}"]?.add(newPlan);
              });
            },
          ).showEditPlanDialogue();
        },
        child: const Icon(Icons.edit),
      ),
    );
  }

  Padding expensePageButton(TripModel trip) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: InkWell(
        onTap: () {
          Get.to(() => ExpenseScreen(
                tripId: trip.id,
                tripStartDate: trip.rangeStart,
                tripEndDate: trip.rangeEnd,
              ));
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.10,
          height: MediaQuery.of(context).size.height * 0.06,
          decoration: BoxDecoration(
              color: primaryColor, borderRadius: BorderRadius.circular(10)),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextWidget(
                    content: "Expense",
                    fontSize: MediaQuery.of(context).size.width * 0.01,
                    fontWeight: FontWeight.bold,
                    color: white,
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: MediaQuery.of(context).size.width * 0.01,
                    color: white,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget tabContainer({
    required BuildContext context,
    required String day,
    required int index,
    required DateTime date,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () {
        setState(() {
          selectTab = index;
        });
      },
      child: animatedContainerWidget(
        selectTab: selectTab,
        index: index,
        context: context,
        day: day,
        date: date,
      ),
    );
  }

  void updateTripActivities(Map<String, List<String>> updatedActivities) {
    setState(() {
      trip.activities = updatedActivities;
    });
  }
}
