import 'dart:developer';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_travelo_app/Controller/Hive/user_functions.dart';
import 'package:my_travelo_app/Views/Screens/Sub_Screens/add_dream_destination_screen.dart';
import 'package:my_travelo_app/Views/Screens/Sub_Screens/edit_dream_destination.dart';
import 'package:my_travelo_app/Views/Screens/Widgets/show_dialogues.dart';
import 'package:my_travelo_app/constants/constable.dart';
import 'package:my_travelo_app/constants/constant.dart';
import 'package:my_travelo_app/constants/primary_button.dart';
import 'package:my_travelo_app/Models/user_model.dart';

class DreamDestinationScreen extends StatefulWidget {
  final String? userId;
  const DreamDestinationScreen({super.key, this.userId});

  @override
  State<DreamDestinationScreen> createState() => _DreamDestinationScreenState();
}

class _DreamDestinationScreenState extends State<DreamDestinationScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  void loadData() async {
    await dreamPlaceToList(userId: widget.userId.toString());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: primaryColor,
        foregroundColor: white,
        centerTitle: true,
        title: TextWidget(
            content: "Dream Destination",
            fontSize: 20,
            fontWeight: FontWeight.bold),
      ),
      body: ValueListenableBuilder(
          valueListenable: dreamDestinationListener,
          builder: (context, value, child) {
            log("Rebuilding with ${value.length} items");
            return Padding(
              padding: const EdgeInsets.all(15),
              child: ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    DreamDestinationModel data =
                        dreamDestinationListener.value[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                            height: 230,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.grey[300],
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.black45,
                                      spreadRadius: 8,
                                      blurRadius: 32)
                                ]),
                            child: Center(
                              child: Stack(
                                children: [
                                  CarouselSlider.builder(
                                      itemCount: data.placeImage.length,
                                      itemBuilder: (BuildContext context,
                                          int index, int realIndex) {
                                        final images = data.placeImage[index];

                                        return Image.file(
                                          File(images),
                                          fit: BoxFit.cover,
                                          height: double.infinity,
                                          width: double.infinity,
                                        );
                                      },
                                      options: CarouselOptions(
                                          height: 230,
                                          autoPlay: true,
                                          viewportFraction: 1.0)),
                                  Container(
                                    width: double.infinity,
                                    height: double.infinity,
                                    color: Colors.black.withOpacity(0.4),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 58,
                                          ),
                                          TextWidget(
                                            content:
                                                "Destination       :  ${data.destination}",
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: white,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5),
                                            child: TextWidget(
                                              content:
                                                  "Total Amount        :  ${data.totalExpense}",
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                              color: white,
                                            ),
                                          ),
                                          TextWidget(
                                            content:
                                                "Total Savings        :  ${data.totalSavings}",
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: white,
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 80),
                                            child: LinearProgressIndicator(
                                              value: data.totalSavings >=
                                                      data.totalExpense
                                                  ? 1.0
                                                  : data.totalSavings /
                                                      data.totalExpense,
                                              color: primaryColor,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 12,
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              addSavingAmount(index);
                                            },
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: primaryColor,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 52,
                                                        vertical: 12),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10))),
                                            child: TextWidget(
                                              content: "Add Savings",
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: white,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        CircleAvatar(
                                          backgroundColor:
                                              white.withOpacity(0.3),
                                          radius: 20,
                                          child: IconButton(
                                              onPressed: () {
                                                Get.to(() =>
                                                    EditDreamDestinationScreen(
                                                      editDestination: data,
                                                      index: index,
                                                    ));
                                              },
                                              icon: const Icon(Icons.edit)),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        CircleAvatar(
                                          backgroundColor:
                                              white.withOpacity(0.3),
                                          radius: 20,
                                          child: IconButton(
                                              onPressed: () async {
                                                showDeletedDialogue(
                                                  context: context,
                                                  tittle: "Delete",
                                                  conformText:
                                                      "Are you sure want to delete this item",
                                                  onpressed: () async {
                                                    await deleteDreamPlace(
                                                        destination: data);
                                                    Get.back();
                                                  },
                                                );
                                              },
                                              icon: const Icon(Icons.delete_rounded,
                                                  color: primaryColor)),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )),
                      ),
                    );
                  }),
            );
          }),
      floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: FloatingActionButton(
            backgroundColor: primaryColor,
            onPressed: () async {
              Get.to(
                  () => AddDreamDestinationScreen(
                        userId: widget.userId,
                      ),
                  transition: Transition.rightToLeft);
            },
            child: const Icon(
              Icons.add,
              color: white,
            ),
          )),
    );
  }

  void addSavingAmount(
    int index,
  ) {
    final DreamDestinationModel destination =
        dreamDestinationListener.value[index];

    final double remainingExpense =
        destination.totalExpense - destination.totalSavings;

    if (remainingExpense <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: red,
          content: TextWidget(
            content: "Total savings have reached the total expense.",
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: white,
          )));
      return;
    } else {
      showAddSavingDialogue(
        context: context,
        reminingExpenses: remainingExpense,
        onAddSaving: (amount) => addSavigs(index, amount, destination),
      );
    }
  }
}
