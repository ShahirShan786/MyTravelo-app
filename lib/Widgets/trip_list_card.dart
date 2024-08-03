

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:my_travelo_app/Functions/user_functions.dart';
import 'package:my_travelo_app/constants/constable.dart';
import 'package:my_travelo_app/constants/constant.dart';
import 'package:my_travelo_app/models/user_model.dart';

class TripListCard extends StatefulWidget {
  final TripModel trip;
  final  int index;
  final BuildContext context;
  const TripListCard({super.key, required this.trip, required this.index, required this.context});

  @override
  State<TripListCard> createState() => _TripListCardState();
}

class _TripListCardState extends State<TripListCard> {
  late String startDay;
  late String endDay;
  @override
  void initState() {
 
    super.initState();
    TripModel trip = tripList.value[widget.index];
    startDay = DateFormat('dd MMM yyyy').format(trip.rangeStart);
    endDay = DateFormat('dd MMM yyyy').format(trip.rangeEnd);
  }
  @override
  Widget build(BuildContext context) {
    TripModel trip = widget.trip;
    return  Card(
              color: Colors.green[50],
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  
                  child: Padding(
                    padding: EdgeInsets.all(8.0.w),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.greenAccent[100],
                          radius: 32.r,
                          child: Icon( 
                            Icons.check_sharp,
                            size: 25.r,
                          ),
                        ),
                        Padding(
                          padding:  EdgeInsets.all(5.w),
                          child: SizedBox(
                            width: 274.w,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 15.h,
                                ),
                                Padding(
                                  padding:  EdgeInsets.only(left: 10.w),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextWidget(
                                          content: trip.destination,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600),
                                      TextWidget(
                                          content: "04 : 07PM",
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.normal)
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Padding(
                                  padding:  EdgeInsets.only(left: 10.w),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextWidget(
                                          content: "$startDay to $endDay",
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.normal),
                                      IconButton(
                                          onPressed: () {},
                                          icon:const Icon(
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
            );
  }
}