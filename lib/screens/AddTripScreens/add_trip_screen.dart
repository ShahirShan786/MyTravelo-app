import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_travelo_app/Widgets/text_feilds.dart';
import 'package:my_travelo_app/constants/constable.dart';
import 'package:my_travelo_app/constants/constant.dart';
import 'package:my_travelo_app/constants/primary_button.dart';
import 'package:my_travelo_app/screens/AddTripScreens/option_screen.dart';
import 'package:table_calendar/table_calendar.dart';

class AddTripScreens extends StatefulWidget {
  const AddTripScreens({super.key});

  @override
  State<AddTripScreens> createState() => _AddTripScreensState();
}

class _AddTripScreensState extends State<AddTripScreens> {
  @override
  Widget build(BuildContext context) {
    late TextEditingController destinationController = TextEditingController();
    DateTime today = DateTime.now();

    return Scaffold(
        body: SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned(
                top: 50,
                left: 20,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[300], shape: BoxShape.circle),
                    width: 40,
                    height: 40,
                    child: const Icon(Icons.close),
                  ),
                )),
            Center(
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 50,
                  ),
                  TextWidget(
                      content: "plan a new trip",
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Column(
                        children: [
                          TextWidget(
                              content: "Build an itinerary and map out your",
                              color: secondaryColor,
                              fontSize: 17,
                              fontWeight: FontWeight.w600),
                          TextWidget(
                              content: "upcoming travel plans",
                              color: secondaryColor,
                              fontSize: 17,
                              fontWeight: FontWeight.w600),
                          const SizedBox(
                            height: 15,
                          ),
                          TExtFeilds(
                            labelText: "Where to?",
                            hintText: "eg., Munnar, Kodak",
                            controller: destinationController,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: TextWidget(
                                content: "Pick your Dates and Time",
                                fontSize: 20,
                                fontWeight: FontWeight.w700),
                          ),
                          TableCalendar(
                            focusedDay: today,
                            rowHeight: 40,
                            headerStyle: const HeaderStyle(
                                formatButtonVisible: false,
                                titleCentered: true),
                            firstDay: DateTime.utc(2010, 10, 14),
                            lastDay: DateTime.utc(2030, 10, 14),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          TextWidget(
                              content: "Time is 10 : 15 AM",
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                          const SizedBox(
                            height: 20,
                          ),
                          TextButton(
                              style: TextButton.styleFrom(
                                  fixedSize: const Size(150, 25),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  side: const BorderSide(color: Colors.black)),
                              onPressed: () {
                                _showTimePicker(context);
                              },
                              child: const Text(
                                "Pick your time",
                                style: TextStyle(color: Colors.purple),
                              )),
                          const SizedBox(
                            height: 25,
                          ),
                          PrimaryButton(
                              backgroundColor: primaryColor,
                              content: TextWidget(
                                  content: "Start planning",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700),
                              width: 250,
                              height: 45,
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => OptionScreen(),
                                ));
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

  Future<void> _showTimePicker(BuildContext context) async {
    await showTimePicker(context: context, initialTime: TimeOfDay.now());
  }
}
