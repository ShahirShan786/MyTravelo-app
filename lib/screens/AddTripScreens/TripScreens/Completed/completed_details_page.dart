import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:my_travelo_app/Functions/user_functions.dart';
import 'package:my_travelo_app/constants/constant.dart';
import 'package:my_travelo_app/models/user_model.dart';

class CompletedDetailsPage extends StatefulWidget {
  final TripModel trip;
  const CompletedDetailsPage({super.key, required this.trip});

  @override
  State<CompletedDetailsPage> createState() => _CompletedDetailsPageState();
}

class _CompletedDetailsPageState extends State<CompletedDetailsPage> {
  ValueNotifier<List<CompletedTripModelPhotos>> completedTripListPhotos =
      ValueNotifier([]);
  bool _photosEmpty = true;
  late String startDate;
  late String endDate;

  @override
  void initState() {
    for (var values in completedTripListPhotos.value) {
      log("database trip id :${values.id}");
      log("trip id :${widget.trip.id}");
      if (values.id == widget.trip.id) {
        _photosEmpty = false;
      }

      log("id :${widget.trip.id}");
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    startDate = DateFormat("dd MMM yyyy").format(widget.trip.rangeStart);
    endDate = DateFormat("dd MMM yyyy").format(widget.trip.rangeEnd);

    return Scaffold(
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.add_event,
        children: [
          SpeedDialChild(
            onTap: () async {
              List<XFile> photos = await ImagePicker().pickMultiImage();

              Future.forEach(photos, (elements) async {
                addMemmories(
                  completedTrips: CompletedTripModelPhotos(
                      photos: elements.path,
                      id: widget.trip.id,
                      tripId: widget.trip.id),
                );
              });
            },
            child: const Icon(Icons.photo_library_outlined),
            label: "Add Photos",
          ),
          SpeedDialChild(
              child: const Icon(Icons.message_outlined), label: "About Trip`"),
        ],
      ),
      appBar: AppBar(
        centerTitle: true,
        title: TextWidget(
            content: "Trip Details", fontSize: 20, fontWeight: FontWeight.bold),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                  content: "To ${widget.trip.destination}",
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              SizedBox(
                height: 10,
              ),
              TextWidget(
                  content: "Started on $startDate to $endDate ",
                  fontSize: 15,
                  fontWeight: FontWeight.w600),
              SizedBox(
                height: 10,
              ),
              TextWidget(
                  content: "Add Photos",
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              _photosEmpty
                  ? SizedBox()
                  : ColoredBox(
                      color: Colors.yellow,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: ValueListenableBuilder(
                          valueListenable: completedTripListPhotos,
                          builder: (context, value, child) {
                            List<CompletedTripModelPhotos> lis = [];
                            List<String> img = [];
                            for (var value in completedTripListPhotos.value) {
                              log("--valueTripId = ${value.tripId}");
                              log("--trip-userId = ${widget.trip.id}");
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
                                        child: Center(
                                          child: Text("No Photos available"),
                                        ),
                                      )
                                    ],
                                  )
                                : GridView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: lis.length,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 3,
                                            childAspectRatio: 1.2),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Image.file(
                                              File(lis[index].photos),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                          },
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
