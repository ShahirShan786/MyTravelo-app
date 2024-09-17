import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

  const UpcommingDetailsPage(
      {super.key,required this.trip});

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

    return Scaffold(
      appBar: PrimaryAppBar(
        backgroundColors: white,
        actions: [expensePageButton(trip)],
      ),
      body: Center(
          child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:  EdgeInsets.symmetric(
                horizontal: 40.w,
              ),
              child: Card(
                elevation: 10,
                child: Container(
                  width: double.infinity,
                  height: 120.h,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20.r)),
                  child: Center(
                    child: Column(
                      children: [
                         SizedBox(
                          height: 25.h,
                        ),
                        TextWidget(
                            content: trip.destination,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold),
                         SizedBox(
                          height: 12.h,
                        ),
                        TextWidget(
                            content: "Started on $dateStart",
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600),
                      ],
                    ),
                  ),
                ),
              ),
            ),
             SizedBox(
              height: 10.h,
            ),
            companions.isNotEmpty
                ? CompanionBox(
                    companion: companions,
                    trip: trip,
                  )
                : const SizedBox(),
            TextWidget(
                content: "Your plans are",
                fontSize: 20.sp,
                fontWeight: FontWeight.w700),
             SizedBox(
              height: 3.h,
            ),
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
                          height: 25.h,
                          width: 25.w,
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
          width: 100.w,
          height: 45.h,
          decoration: BoxDecoration(
              color: primaryColor, borderRadius: BorderRadius.circular(10.r)),
          child: Center(
            child: Padding(
              padding:  EdgeInsets.all(8.0.r),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextWidget(
                    content: "Expense",
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: white,
                  ),
                   Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 20.w,
                    color: white,
                    weight: 20,
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
      borderRadius: BorderRadius.circular(10.r),
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

 void updateTripActivities(Map<String , List<String>>updatedActivities){
  setState(() {
    trip.activities = updatedActivities;

  });
 }
}
