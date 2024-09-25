import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_travelo_app/Controller/Hive/user_functions.dart';
import 'package:my_travelo_app/Views/Screens/Widgets/textFormFeilds.dart';
import 'package:my_travelo_app/constants/constable.dart';
import 'package:my_travelo_app/constants/constant.dart';
import 'package:my_travelo_app/Models/user_model.dart';
import 'package:my_travelo_app/Views/Screens/Primary_Screens/Schedule/Pages/schedule_screen.dart';

class EditTripDialogueBox {
  final BuildContext context;
  final TripModel trip;
  final int index;
  final Function() onSave;

  late TextEditingController destinationController;
  late TextEditingController companionController;
  late TextEditingController startDateController;
  late TextEditingController endDateController;

  EditTripDialogueBox({
    required this.context,
    required this.trip,
    required this.index,
    required this.onSave,
  }) {
    destinationController = TextEditingController(text: trip.destination);
    companionController =
        TextEditingController(text: trip.companion!.join(', '));
    startDateController = TextEditingController(
        text: DateFormat("yyyy-MM-dd").format(trip.rangeStart));
    endDateController = TextEditingController(
        text: DateFormat("yyyy-MM-dd").format(trip.rangeEnd));
  }

  void showEditDialogue() {
    DateTime startDate = trip.rangeEnd;
    DateTime endDate = trip.rangeEnd;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          final screenWidth = MediaQuery.of(context).size.width;
          final screenHeight = MediaQuery.of(context).size.height;
          return AlertDialog(
            title: TextWidget(
                content: "Edit your Trip",
                fontSize: screenWidth * 0.02,
                fontWeight: FontWeight.bold),
            content: SingleChildScrollView(
              child: SizedBox(
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 300),
                      child: Textformfeilds(
                        borderColor: secondaryColor,
                        focusedColor: black,
                        controller: destinationController,
                        keyboardType: TextInputType.text,
                        labelColor: secondaryColor,
                        labelText: "Destination",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter the destination";
                          }
                          return null;
                        },
                      ),
                    ),
                    trip.companion != null && trip.companion!.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.only(right: 300),
                            child: Textformfeilds(
                              borderColor: secondaryColor,
                              focusedColor: black,
                              controller: companionController,
                              keyboardType: TextInputType.text,
                              labelColor: secondaryColor,
                              labelText: "Companion",
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Add companion";
                                }
                                return null;
                              },
                            ),
                          )
                        : const SizedBox(),
                    Padding(
                      padding: const EdgeInsets.only(right: 300),
                      child: Textformfeilds(
                        borderColor: secondaryColor,
                        focusedColor: black,
                        controller: startDateController,
                        keyboardType: TextInputType.text,
                        labelColor: secondaryColor,
                        labelText: "Stating Date",
                        ontap: () async {
                          await selectDate(context, startDate, (pickedFile) {
                            startDate = pickedFile;
                            startDateController.text =
                                DateFormat("yyy-MM-dd").format(pickedFile);
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Pick your starting date";
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 300),
                      child: Textformfeilds(
                        borderColor: secondaryColor,
                        focusedColor: black,
                        controller: endDateController,
                        keyboardType: TextInputType.text,
                        labelColor: secondaryColor,
                        labelText: "End Date",
                        ontap: () async {
                          await selectDate(context, endDate, (pickedDate) {
                            endDate = pickedDate;
                            endDateController.text =
                                DateFormat("yyyy-MM-dd").format(pickedDate);
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Pick your ending date";
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: TextWidget(
                      content: "Cancel",
                      fontSize: screenWidth * 0.01,
                      fontWeight: FontWeight.w600)),
              TextButton(
                  onPressed: () {
                    trip.destination = destinationController.text;
                    trip.companion = companionController.text
                        .split(",")
                        .map((companion) => companion.trim())
                        .toList();
                    trip.rangeStart = startDate;
                    trip.rangeEnd = endDate;

                    List<DateTime> newDays = getDaysInRange(startDate, endDate);
                    Map<String, List<String>> updatedActivities = {};

                    for (int i = 0; i < newDays.length; i++) {
                      String dayKey = "Day ${i + 1}";
                      updatedActivities[dayKey] = trip.activities[dayKey] ?? [];
                    }

                    trip.activities = updatedActivities;

                    updateTrip(trip: trip);

                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const ScheduleScreen()));
                  },
                  child: TextWidget(
                      content: "Update",
                      fontSize: screenWidth * 0.01,
                      fontWeight: FontWeight.w600))
            ],
          );
        });
  }

  Future<void> selectDate(BuildContext context, DateTime initialDate,
      Function(DateTime) onDateSelected) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(2010),
        lastDate: DateTime(2050));

    if (picked != null) {
      onDateSelected(picked);
    }
  }

  List<DateTime> getDaysInRange(DateTime start, DateTime end) {
    List<DateTime> days = [];
    for (int i = 0; i <= end.difference(start).inDays; i++) {
      days.add(start.add(Duration(days: i)));
    }
    return days;
  }
}
