import 'dart:core';
import 'dart:developer';

import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_travelo_app/Functions/user_functions.dart';
import 'package:my_travelo_app/Widgets/multi_contact_picker.dart';
import 'package:my_travelo_app/Widgets/textFormFeilds.dart';
import 'package:my_travelo_app/Widgets/trip_deatails_screen_widget.dart';
import 'package:my_travelo_app/constants/constable.dart';
import 'package:my_travelo_app/constants/constant.dart';
import 'package:my_travelo_app/dashboard.dart';
import 'package:my_travelo_app/models/user_model.dart';

import 'package:my_travelo_app/screens/AddTripScreens/add_trip_screen.dart';
import 'package:my_travelo_app/screens/AddTripScreens/companion_screen.dart';
import 'package:my_travelo_app/screens/home_screens.dart';

class TripPlanScreen extends StatefulWidget {
  final String? destination;
  final DateTime? selectedRangeStart;
  final DateTime? selectedRangeEnd;
  final String finalSelectTime;
  final List<Contact> selectedContacts;
  const TripPlanScreen({
    super.key,
    required this.destination,
    required this.selectedRangeStart,
    required this.selectedRangeEnd,
    required this.finalSelectTime,
    this.selectedContacts = const [],
  });

  @override
  State<TripPlanScreen> createState() => _TripPlanScreenState();
}

Map<String, List<String>> _stringMap = {};

class _TripPlanScreenState extends State<TripPlanScreen> {
  int _selectTab = 0;
  final TextEditingController _addPlanController = TextEditingController();
  List<DateTime> _days = [];

  @override
  void initState() {
    super.initState();

    // Initialize _days
    _days =
        getDaysInRange(widget.selectedRangeStart!, widget.selectedRangeEnd!);

    // Initialize _stringMap with _days
    for (int i = 0; i < _days.length; i++) {
      String daykey = "Day ${i + 1}";
      _stringMap[daykey] = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: white,
        title: TextWidget(
            content: "Add your trip plan",
            fontSize: 20.sp,
            fontWeight: FontWeight.bold),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 12.w),
            child: InkWell(
              onTap: () async {
                log("button Taped!!!");
                log("Enter to the button fuction");
                if (widget.destination != null &&
                    widget.selectedRangeStart != null &&
                    widget.selectedRangeEnd != null) {
                  final trip = TripModel(
                      destination: widget.destination!,
                      rangeStart: widget.selectedRangeStart!,
                      rangeEnd: widget.selectedRangeEnd!,
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      companion: widget.selectedContacts,
                      activities: _stringMap);

                  await addTrip(trip: trip);

                  // final tripBox = Hive.box<TripModel>(tripDbName);
                  // tripBox.add(TripModel(
                  //     destination: widget-w.destination!,
                  //     rangeStart: widget.selectedRangeStart!,
                  //     rangeEnd: widget.selectedRangeEnd!,
                  //     id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
                  //     companion: widget.selectedContacts,
                  //     activities: _stringMap));

                  log('Selected contacts: ${widget.selectedContacts}');
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Dashboard(),
                  ));
                } else {
                  log("Data couldn't passed");
                }
              },
              child: Container(
                height: 45.h,
                width: 75.w,
                decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(10.r)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextWidget(
                      content: "Add",
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: white,
                    ),
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 18.r,
                      color: white,
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 15.w,
          vertical: 10.h,
        ),
        child: Column(
          children: [
            SizedBox(
              height: 15.h,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (int i = 0; i < _days.length; i++)
                    tabContainer(
                      context: context,
                      day: "Day ${i + 1}",
                      index: i,
                      date: _days[i],
                    ),
                ],
              ),
            ),
            SizedBox(
              height: 25.h,
            ),
            Textformfeilds(
              controller: _addPlanController,
              borderColor: red,
              focusedColor: primaryColor,
              labelText: "Add Day ${_selectTab + 1} plan",
              labelColor: secondaryColor,
              suffics: IconButton(
                  onPressed: () {
                    if (_addPlanController.text.isNotEmpty) {
                      setState(() {
                        _stringMap["Day ${_selectTab + 1}"]
                            ?.add(_addPlanController.text);
                      });
                      _addPlanController.clear();
                    }
                  },
                  icon: const Icon(Icons.add)),
            ),
            SizedBox(
              height: 15.h,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _stringMap["Day ${_selectTab + 1}"]?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  List<String>? plans = _stringMap["Day ${_selectTab + 1}"];
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
                              _stringMap["Day ${_selectTab + 1}"]
                                  ?.remove(plans[index]);
                            });
                          },
                          icon: Icon(Icons.remove)),
                    ),
                  );
                },
              ),
            ),
          ],
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
          _selectTab = index;
        });
      },
      child: animatedContainerWidget(
        selectTab: _selectTab,
        index: index,
        context: context,
        day: day,
        date: date,
      ),
    );
  }
}

_buttonClick({
  required BuildContext context,
}) async {}

List<DateTime> getDaysInRange(DateTime rangeStart, DateTime rangeEnd) {
  List<DateTime> daysInRange = [];

  DateTime currentDay = rangeStart;
  while (
      currentDay.isBefore(rangeEnd) || currentDay.isAtSameMomentAs(rangeEnd)) {
    daysInRange.add(currentDay);

    currentDay = currentDay.add(const Duration(days: 1));
  }
  return daysInRange;
}
