import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:my_travelo_app/Functions/user_functions.dart';
import 'package:my_travelo_app/constants/constable.dart';
import 'package:my_travelo_app/constants/constant.dart';
import 'package:my_travelo_app/models/user_model.dart';
import 'package:my_travelo_app/screens/AddTripScreens/TripScreens/Completed/completed_details_page.dart';

class CompletedPage extends StatefulWidget {
  final String userId;
  const CompletedPage({super.key, required this.userId});

  @override
  State<CompletedPage> createState() => _CompletedPageState();
}

class _CompletedPageState extends State<CompletedPage> {
  late String endDate;
  @override
  void initState() {
    super.initState();
    _initializeCompletedTrips();
  }

  Future<void> _initializeCompletedTrips() async {
    await splitData(widget.userId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(10.w),
        child: ValueListenableBuilder(
            valueListenable: tripListCompleted,
            builder: (context, value, child) {
              return tripListCompleted.value.isNotEmpty
                  ? ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: tripListCompleted.value.length,
                      itemBuilder: (BuildContext context, int index) {
                        TripModel completedTrip =
                            tripListCompleted.value[index];
                        endDate = DateFormat("dd MMM yyyy")
                            .format(completedTrip.rangeEnd);
                        return Card(
                          color: Colors.green[50],
                          child: InkWell(
                            onTap: () {
                              log("Completed trip id :${completedTrip.id}");
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CompletedDetailsPage(
                                      trip: completedTrip,
                                    ),
                                  ));
                            },
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Padding(
                                  padding: EdgeInsets.all(8.0.w),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor:
                                            Colors.greenAccent[100],
                                        radius: 32.r,
                                        child: Icon(
                                          Icons.check_sharp,
                                          size: 25.r,
                                        ),
                                      ),
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
                                                padding:
                                                    EdgeInsets.only(left: 10.w),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    TextWidget(
                                                        content: completedTrip
                                                            .destination,
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                    TextWidget(
                                                        content:
                                                            completedTrip.time,
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
                                                padding:
                                                    EdgeInsets.only(left: 10.w),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    TextWidget(
                                                        content:
                                                            "Completed $endDate",
                                                        fontSize: 13.sp,
                                                        fontWeight:
                                                            FontWeight.normal),
                                                    IconButton(
                                                        onPressed: () {},
                                                        icon: Icon(
                                                          Icons.delete,
                                                          color: primaryColor,
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
                  : Center(
                      child: Text("No completed trips yet."),
                    );
            }));
  }
}
