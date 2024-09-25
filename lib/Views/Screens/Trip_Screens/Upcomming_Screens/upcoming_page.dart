import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_travelo_app/Controller/Hive/user_functions.dart';
import 'package:my_travelo_app/Views/Screens/Widgets/edit_trip_dialoguebox.dart';
import 'package:my_travelo_app/constants/constable.dart';
import 'package:my_travelo_app/constants/constant.dart';
import 'package:my_travelo_app/Models/user_model.dart';
import 'package:my_travelo_app/Views/Screens/Trip_Screens/Upcomming_Screens/upcomming_details_page.dart';

class UpcomingPage extends StatefulWidget {
  final String userId;
  const UpcomingPage({super.key, required this.userId});

  @override
  State<UpcomingPage> createState() => _UpcomingPageState();
}

class _UpcomingPageState extends State<UpcomingPage> {
  ValueNotifier<List<TripModel>> tripList = ValueNotifier([]);
  ValueNotifier<List<TripModel>> filteredTripList = ValueNotifier([]);
  final TextEditingController _searchController = TextEditingController();
  late String startDay;
  late String endDay;
  late String day;
  late String week;

  @override
  void initState() {
    super.initState();
    initializeTrip();
  }

  void initializeTrip() async {
    await splitData(widget.userId);
    tripList.value = await getTrip();
    filteredTripList.value = tripList.value;
    log("tripList length ${tripList.value.length}");
  }

  void filteredTrips(String query) {
    if (query.isEmpty) {
      filteredTripList.value = tripList.value;
    } else {
      filteredTripList.value = tripList.value.where((trip) {
        String formatDate = DateFormat("dd MMM yyyy").format(trip.rangeStart);
        return formatDate.contains(query);
      }).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05, // 5% of screen width
            vertical: screenHeight * 0.01, // 1% of screen height
          ),
          child: TextField(
            keyboardType: TextInputType.datetime,
            controller: _searchController,
            decoration: InputDecoration(
              labelText: "Search by Date (dd MMM yyyy)",
              prefixIcon: const Icon(Icons.search_rounded),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(width: 0.5),
              ),
            ),
            onChanged: (value) {
              filteredTrips(value);
            },
          ),
        ),
        Expanded(
          child: ValueListenableBuilder(
            valueListenable: filteredTripList,
            builder: (context, value, child) {
              return filteredTripList.value.isNotEmpty
                  ? ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: filteredTripList.value.length,
                      itemBuilder: (BuildContext context, int index) {
                        TripModel tripDetails = filteredTripList.value[index];

                        startDay = DateFormat('dd MMM yyyy')
                            .format(tripDetails.rangeStart);
                        endDay = DateFormat('dd MMM yyyy')
                            .format(tripDetails.rangeEnd);
                        day = DateFormat("dd").format(tripDetails.rangeStart);
                        week = DateFormat("EEE").format(tripDetails.rangeStart);

                        return Card(
                          child: InkWell(
                            onTap: () {
                              log("Card Tapped successfully");
                              Get.to(
                                () => UpcommingDetailsPage(
                                  trip: tripDetails,
                                ),
                              );
                            },
                            onLongPress: () {
                              showDeleteDialogue(context, tripDetails);
                            },
                            child: SizedBox(
                              width: screenWidth,
                              child: Padding(
                                padding: EdgeInsets.all(
                                    screenWidth * 0.01), // 2% padding
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: white,
                                      radius: screenWidth * 0.04, // 8% of width
                                      child: Center(
                                        child: Column(
                                          children: [
                                            SizedBox(
                                                height: screenHeight *
                                                    0.01), // Adjust height dynamically
                                            TextWidget(
                                              content: day,
                                              fontSize: screenWidth *
                                                  0.02, // 4% of screen width
                                              fontWeight: FontWeight.bold,
                                            ),
                                            TextWidget(
                                              content: week,
                                              fontSize: screenWidth * 0.02,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.all(screenWidth * 0.02),
                                      child: SizedBox(
                                        width: screenWidth *
                                            0.85, // 65% of screen width
                                        child: Column(
                                          children: [
                                            SizedBox(
                                                height: screenHeight * 0.02),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: screenWidth * 0.03),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  TextWidget(
                                                    content:
                                                        tripDetails.destination,
                                                    fontSize: screenWidth *
                                                        0.025, // 4.5% of screen width
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  TextWidget(
                                                    content: tripDetails.time,
                                                    fontSize: screenWidth *
                                                        0.017, // 3% of screen width
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                                height: screenHeight * 0.01),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: screenWidth * 0.03),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  TextWidget(
                                                    content:
                                                        "$startDay to $endDay",
                                                    fontSize: screenWidth *
                                                        0.020, // 3.5% of screen width
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  IconButton(
                                                    onPressed: () {
                                                      EditTripDialogueBox(
                                                        context: context,
                                                        trip: tripDetails,
                                                        index: index,
                                                        onSave: () {
                                                          setState(() {
                                                            tripList.value[
                                                                    index] =
                                                                tripDetails;
                                                            filteredTripList
                                                                    .value =
                                                                tripList.value;
                                                          });
                                                        },
                                                      ).showEditDialogue();
                                                    },
                                                    icon: const Icon(
                                                      Icons.edit_note_outlined,
                                                      size: 35,
                                                      color: secondaryColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      })
                  : const Center(
                      child: Text("No trips Available"),
                    );
            },
          ),
        ),
      ],
    );
  }

  showDeleteDialogue(BuildContext context, TripModel trip) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: TextWidget(
            content: "Delete",
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          content: TextWidget(
            content: "Are you sure you want to delete this trip?",
            fontSize: 15,
            fontWeight: FontWeight.normal,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: TextWidget(
                content: "Cancel",
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  deleteTrip(trip: trip);
                  initializeTrip();
                });
                Navigator.of(context).pop();
              },
              child: TextWidget(
                content: "Delete",
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        );
      },
    );
  }
}
