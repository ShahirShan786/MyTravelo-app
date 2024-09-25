import 'dart:core';
import 'dart:developer';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_travelo_app/Controller/Hive/user_functions.dart';
import 'package:my_travelo_app/Views/Screens/Trip_Screens/Add_Trip_screens/Trip_Plan/widgets/add_button.dart';
import 'package:my_travelo_app/Views/Screens/Widgets/app_bar.dart';
import 'package:my_travelo_app/Views/Screens/Widgets/textFormFeilds.dart';
import 'package:my_travelo_app/Views/Screens/Widgets/trip_deatails_screen_widget.dart';
import 'package:my_travelo_app/constants/constable.dart';
import 'package:my_travelo_app/constants/constant.dart';
import 'package:my_travelo_app/Models/user_model.dart';
import 'package:my_travelo_app/Views/Screens/Primary_Screens/Schedule/Pages/schedule_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    _days =
        getDaysInRange(widget.selectedRangeStart!, widget.selectedRangeEnd!);

    for (int i = 0; i < _days.length; i++) {
      String daykey = "Day ${i + 1}";
      _stringMap[daykey] = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: PrimaryAppBar(
        titles: "Add your trip plan",
        backgroundColors: BoxColor,
        actions: [addPlanButton()],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.04, // Approximately 15.w
          vertical: screenHeight * 0.01, // Approximately 10.h
        ),
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.02, // Approximately 15.h
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
              height: screenHeight * 0.03, // Approximately 25.h
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
                icon: const Icon(Icons.add),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.02, // Approximately 15.h
            ),
            Expanded(
              child: _stringMap["Day ${_selectTab + 1}"]!.isNotEmpty
                  ? ListView.builder(
                      itemCount:
                          _stringMap["Day ${_selectTab + 1}"]?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        List<String>? plans =
                            _stringMap["Day ${_selectTab + 1}"];
                        return Card(
                          child: ListTile(
                            leading: Container(
                              height: screenHeight * 0.03, // Approximately 25.h
                              width: screenWidth * 0.07, // Approximately 25.w
                              decoration: const BoxDecoration(
                                color: white,
                                shape: BoxShape.circle,
                              ),
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
                              icon: const Icon(Icons.remove),
                            ),
                          ),
                        );
                      },
                    )
                  : Center(
                      child: TextWidget(
                        content: "No plans are available",
                        fontSize: screenHeight * 0.02, // Approximately 15.sp
                        fontWeight: FontWeight.w500,
                        color: secondaryColor,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Padding addPlanButton() {
    return Padding(
      padding: EdgeInsets.only(
          right:
              MediaQuery.of(context).size.width * 0.02), // Approximately 12.w
      child: InkWell(
        onTap: () async {
          SharedPreferences prefz = await SharedPreferences.getInstance();
          final userId = prefz.getString("currentuserId");
          log("Current passed userId is :$userId");

          final companion = widget.selectedContacts
              .map((contact) => contact.displayName ?? "")
              .toList();

          if (widget.destination != null &&
              widget.selectedRangeStart != null &&
              widget.selectedRangeEnd != null) {
            final trip = TripModel(
              destination: widget.destination!,
              rangeStart: widget.selectedRangeStart!,
              rangeEnd: widget.selectedRangeEnd!,
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              companion: companion,
              time: widget.finalSelectTime,
              activities: _stringMap,
              userId: userId.toString(),
            );

            await addTrip(trip: trip);

            log('Selected contacts: ${widget.selectedContacts}');
            Get.to(
              () => ScheduleScreen(
                userId: userId,
              ),
              transition: Transition.native,
            );
          } else {
            log("Data couldn't pass");
          }
        },
        child: const AddButton(),
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
