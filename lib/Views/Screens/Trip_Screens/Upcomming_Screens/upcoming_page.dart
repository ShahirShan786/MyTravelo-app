  import 'dart:developer';
  import 'package:flutter/material.dart';
  import 'package:flutter_screenutil/flutter_screenutil.dart';
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

    // void initializeTrip()async{
    //   await splitData(widget.userId);
    //   setState(() {
        
    //   });
    // }

     void initializeTrip() async {
      await splitData(widget.userId);
      tripList.value = await getTrip();
      filteredTripList.value = tripList.value;
      log("tripList lenth ${tripList.value.length}");
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
      return Column(
        children: [
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
            child: TextField(
              keyboardType: TextInputType.datetime,
              controller: _searchController,
              decoration: InputDecoration(
                  labelText: "Search by Date ( dd MMM yyyy)",
                  prefixIcon: const Icon(Icons.search_rounded),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.r),
                      borderSide:  BorderSide(width: 0.5.w))),
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
                            TripModel tripDetailes =
                                filteredTripList.value[index];

                            startDay = DateFormat('dd MMM yyyy')
                                .format(tripDetailes.rangeStart);
                            endDay = DateFormat('dd MMM yyyy')
                                .format(tripDetailes.rangeEnd);
                            day =
                                DateFormat("dd").format(tripDetailes.rangeStart);
                            week =
                                DateFormat("EEE").format(tripDetailes.rangeStart);

                            return Card(
                              child: InkWell(
                                onTap: () {
                                  log("Card Tapped sucessfully");
                                  Get.to(
                                    () => UpcommingDetailsPage(
                                      trip: tripDetailes,
                                    ),
                                  );
                                },
                                onLongPress: () {
                                  showDeleteDialogue(context, tripDetailes);
                                },
                                child: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0.w),
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                              backgroundColor: white,
                                              radius: 32.r,
                                              child: Center(
                                                child: Column(
                                                  children: [
                                                    const SizedBox(
                                                      height: 7,
                                                    ),
                                                    TextWidget(
                                                        content: day,
                                                        fontSize: 15.sp,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    TextWidget(
                                                        content: week,
                                                        fontSize: 15.sp,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ],
                                                ),
                                              )),
                                          Padding(
                                            padding: EdgeInsets.all(5.w),
                                            child: SizedBox(
                                              width: 274.w,
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height: 15.h,
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 10.w),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        TextWidget(
                                                            content: tripDetailes
                                                                .destination,
                                                            fontSize: 18.sp,
                                                            fontWeight:
                                                                FontWeight.w600),
                                                        TextWidget(
                                                            content:
                                                                tripDetailes.time,
                                                            fontSize: 13.sp,
                                                            fontWeight:
                                                                FontWeight.normal)
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 5.h,
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 10.w),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        TextWidget(
                                                            content:
                                                                "$startDay to $endDay",
                                                            fontSize: 14.sp,
                                                            fontWeight:
                                                                FontWeight.w500),
                                                        IconButton(
                                                            onPressed: () {
                                                              EditTripDialogueBox(
                                                                context: context,
                                                                trip:
                                                                    tripDetailes,
                                                                index: index,
                                                                onSave: () {
                                                                  setState(() {
                                                                    tripList.value[index] =tripDetailes;
                                                                    filteredTripList.value = tripList.value;
                                                                  });
                                                                },
                                                              ).showEditDialogue();
                                                            },
                                                            icon: const Icon(
                                                              Icons
                                                                  .edit_note_outlined,
                                                              color:
                                                                  secondaryColor,
                                                            ))
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )),
                              ),
                            );
                          })
                      : const Center(
                          child: Text("No trips Available"),
                        );
                }),
          )
        ],
      );
    }

    showDeleteDialogue(BuildContext context, TripModel trip) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: TextWidget(
                  content: "Delete", fontSize: 20.sp, fontWeight: FontWeight.bold),
              content: TextWidget(
                  content: "Are you sure you want to delete this trip?",
                  fontSize: 15.sp,
                  fontWeight: FontWeight.normal),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: TextWidget(
                        content: "Cancel",
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600)),
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
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600)),
              ],
            );
          });
    }
  }
