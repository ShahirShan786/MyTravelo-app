import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:my_travelo_app/Functions/user_functions.dart';
import 'package:my_travelo_app/Widgets/textFormFeilds.dart';
import 'package:my_travelo_app/constants/constable.dart';
import 'package:my_travelo_app/constants/constant.dart';
import 'package:my_travelo_app/dashboard.dart';
import 'package:my_travelo_app/models/user_model.dart';
import 'package:my_travelo_app/screens/schedule_screen.dart';
import 'package:table_calendar/table_calendar.dart';

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
        TextEditingController(text: trip.companion.join(', '));
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
          return AlertDialog(
            title: TextWidget(
                content: "Edit your Trip",
                fontSize: 20,
                fontWeight: FontWeight.bold),
            content: SingleChildScrollView(
              child: Container(
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Textformfeilds(
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
                    Textformfeilds(
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
                    Textformfeilds(
                      borderColor: secondaryColor,
                      focusedColor: black,
                      controller: startDateController,
                      keyboardType: TextInputType.text,
                      labelColor: secondaryColor,
                      labelText: "Stating Date",
                      ontap: () async {
                        await selectDate(context, startDate, (PickedFile) {
                          startDate = PickedFile;
                          startDateController.text =
                              DateFormat("yyy-MM-dd").format(PickedFile);
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Pick your starting date";
                        }
                        return null;
                      },
                    ),
                    Textformfeilds(
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
                      fontSize: 15,
                      fontWeight: FontWeight.w600)),
              TextButton(
                  onPressed: () {
                    trip.destination = destinationController.text;
                    trip.companion = companionController.text
                    .split(",")
                    .map((companion)=> companion.trim()).toList();
                    trip.rangeStart = startDate;
                    trip.rangeEnd = endDate;
                    updateTrip(trip: trip);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ScheduleScreen()));
                  },
                  child: TextWidget(
                      content: "Update",
                      fontSize: 15,
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
}
