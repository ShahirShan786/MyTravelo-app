import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:my_travelo_app/Controller/Hive/user_functions.dart';
import 'package:my_travelo_app/Views/Screens/Trip_Screens/Completed_Screens/blog_page.dart';
import 'package:my_travelo_app/Views/Screens/Widgets/app_bar.dart';
import 'package:my_travelo_app/Views/Screens/Widgets/photo_view_page.dart';
import 'package:my_travelo_app/constants/constable.dart';
import 'package:my_travelo_app/constants/constant.dart';
import 'package:my_travelo_app/Models/user_model.dart';

class CompletedDetailsPage extends StatefulWidget {
  final TripModel trip;
  const CompletedDetailsPage({super.key, required this.trip});

  @override
  State<CompletedDetailsPage> createState() => _CompletedDetailsPageState();
}

class _CompletedDetailsPageState extends State<CompletedDetailsPage> {
  bool _photosEmpty = true;
  bool _blogEmpty = true;
  late String startDate;
  late String endDate;
  List<CompletedTripModelBlog> blog = [];
  @override
  void initState() {
    tripBlogToList();
    completedTripToList();
    
    _checkPhotos();

    completedTripListPhotos.addListener(_checkPhotos);
    for (var value in completedTripListBlog.value) {
      if (value.tripId == widget.trip.id) {
        _blogEmpty = false;
      }
    }

    super.initState();
  }

  void _checkPhotos() {
    _photosEmpty = !completedTripListPhotos.value
        .any((photo) => photo.tripId == widget.trip.id);
    setState(() {});
  }


  @override
  void dispose() {
    completedTripListPhotos.removeListener(_checkPhotos);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    startDate = DateFormat("dd MMM yyyy").format(widget.trip.rangeStart);
    endDate = DateFormat("dd MMM yyyy").format(widget.trip.rangeEnd);

    return Scaffold(
      floatingActionButton: SpeedDial(
        backgroundColor: primaryColor,
        foregroundColor: white,
        animatedIcon: AnimatedIcons.add_event,
        children: [
          SpeedDialChild(
            onTap: () async {
              List<XFile> photos = await ImagePicker().pickMultiImage();

              Future.forEach(photos, (elements) async {
                addMemmories(
                  completedTrips: CompletedTripModelPhotos(
                      photos: elements.path,
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      tripId: widget.trip.id),
                );
              });
            },
            child: const Icon(Icons.photo_library_outlined),
            label: "Add Photos",
          ),
          SpeedDialChild(
              onTap: () {
                blog.isEmpty
                    ? Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => BlogPage(
                              trip: widget.trip,
                              startDate: startDate,
                              endDate: endDate,
                            )))
                    : Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => BlogPage(
                          trip: widget.trip,
                          startDate: startDate,
                          endDate: endDate,
                          blog: blog[0],
                        ),
                      ));
              },
              child: const Icon(Icons.message_outlined),
              label: "Add Blogs")
        ],
      ),
      appBar: const PrimaryAppBar(
        titles: "Trip Details",
        backgroundColors: BoxColor,
      ),
      body: SingleChildScrollView(
          child: ValueListenableBuilder(
              valueListenable: completedTripListBlog,
              builder: (context, value, child) {
                for (var value in completedTripListBlog.value) {
                  if (value.tripId == widget.trip.id) {
                    blog.add(value);
                    _blogEmpty = true;
                  }
                }
                return Padding(
                  padding:  EdgeInsets.all(10.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                          content: "To ${widget.trip.destination}",
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold),
                       SizedBox(
                        height: 10.h,
                      ),
                      TextWidget(
                          content: "Started on $startDate to $endDate ",
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600),
                       SizedBox(
                        height: 10.h,
                      ),
                      blog.isEmpty
                          ? const SizedBox()
                          :  TextWidget(
                              content: "About Trip",
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold),
                      blog.isNotEmpty
                          ? Padding(
                              padding:  EdgeInsets.symmetric(
                                  horizontal: 5.w, vertical: 2.h),
                              child: TextWidget(
                                  content: blog[0].blog,
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.w400),
                            )
                          : const SizedBox(),
                      _photosEmpty
                          ? const SizedBox()
                          :  TextWidget(
                              content: "Trip Memmories",
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold),
                      SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: ValueListenableBuilder(
                          valueListenable: completedTripListPhotos,
                          builder: (context, value, child) {
                            List<CompletedTripModelPhotos> lis = [];
                            List<String> img = [];
                            for (var value in completedTripListPhotos.value) {
                              log("--valueTripId = ${value.tripId}");
                              log("--trip-tripId = ${widget.trip.id}");
                              if (value.tripId == widget.trip.id) {
                                lis.add(value);
                                img.add(value.photos);
                                _photosEmpty = true;
                              }
                            }
                            return lis.isEmpty
                                ? Column(
                                    children: [
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height,
                                        child: const Center(
                                          child: Text("No Photos available"),
                                        ),
                                      )
                                    ],
                                  )
                                : GridView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: lis.length,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 3,
                                            childAspectRatio: 1.2),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Padding(
                                        padding:  EdgeInsets.all(8.0.w),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20.r)),
                                          child: InkWell(
                                            onLongPress: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: const Text("Delete"),
                                                    content: const Text(
                                                      "Are you sure you want to delete?",
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () {
                                                          removeImage(
                                                              completedTripImage:
                                                                  lis[index]);
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child:
                                                            const Text("Yes"),
                                                      ),
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: const Text("No"),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            onTap: () {},
                                            child: InkWell(
                                              onTap: () {
                                                Get.to(() => PhotoViewPage(
                                                    photos: img, index: index));
                                              },
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                child: Image.file(
                                                  File(lis[index].photos),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                          },
                        ),
                      ),
                    ],
                  ),
                );
              })),
    );
  }
}
