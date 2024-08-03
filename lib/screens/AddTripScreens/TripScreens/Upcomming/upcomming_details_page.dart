import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:my_travelo_app/Widgets/companion_box.dart';
import 'package:my_travelo_app/Widgets/edit_plan_dialogue.dart';
import 'package:my_travelo_app/Widgets/trip_deatails_screen_widget.dart';
import 'package:my_travelo_app/constants/constable.dart';
import 'package:my_travelo_app/constants/constant.dart';
import 'package:my_travelo_app/models/user_model.dart';
import 'package:my_travelo_app/screens/AddTripScreens/trip_plan_screen.dart';

class UpcommingDetailsPage extends StatefulWidget {
  // final String destination;
  // final String startDate;
  // final List<String> companion;
  // final Map<String, List<String>> activities;
  final TripModel trip;

  const UpcommingDetailsPage(
      {super.key,
      // required this.destination,
      // required this.startDate,
      // required this.companion,
      // required this.activities,
      required this.trip});

  @override
  State<UpcommingDetailsPage> createState() => _UpcommingDetailsPageState();
}

class _UpcommingDetailsPageState extends State<UpcommingDetailsPage> {
  int selectTab = 0;
  @override
  Widget build(BuildContext context) {
    final TripModel trip = widget.trip;
    Map<String, List<String>> activities = trip.activities;
    final dateStart = DateFormat("dd MMM yyyy").format(trip.rangeStart);
    final destination = trip.destination;
    final List<String> companions = trip.companion;
    List<DateTime> days = getDaysInRange(trip.rangeStart, trip.rangeEnd);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
              ),
              child: Card(
                elevation: 10,
                child: Container(
                  width: double.infinity,
                  height: 120,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 25,
                        ),
                        TextWidget(
                            content: trip.destination,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                        SizedBox(
                          height: 12,
                        ),
                        TextWidget(
                            content: "Started on $dateStart",
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            companions.isNotEmpty
                ? CompanionBox(
                    companion: companions,
                    trip: trip,
                  )
                : SizedBox(),
            TextWidget(
                content: "Your plans are",
                fontSize: 20,
                fontWeight: FontWeight.w700),
            SizedBox(
              height: 3,
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
        child: Icon(Icons.edit),
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
}
