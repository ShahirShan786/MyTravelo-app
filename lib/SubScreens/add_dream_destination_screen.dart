import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_travelo_app/Functions/user_functions.dart';
import 'package:my_travelo_app/SubScreens/dream_destination_screen.dart';
import 'package:my_travelo_app/Widgets/textFormFeilds.dart';
import 'package:my_travelo_app/Widgets/textfeild.dart';
import 'package:my_travelo_app/constants/constable.dart';
import 'package:my_travelo_app/constants/constant.dart';
import 'package:my_travelo_app/constants/primary_button.dart';
import 'package:my_travelo_app/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddDreamDestinationScreen extends StatefulWidget {
  final String? userId;
  const AddDreamDestinationScreen({super.key, this.userId});

  @override
  State<AddDreamDestinationScreen> createState() =>
      _AddDreamDestinationScreenState();
}

class _AddDreamDestinationScreenState extends State<AddDreamDestinationScreen> {
  final TextEditingController _destinationController = TextEditingController();
  final TextEditingController _totalExpenseController = TextEditingController();
  final TextEditingController _totalSavingsController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<String> selectedImages = [];
  int displayImage = 0;
  @override
  Widget build(BuildContext context) {
    log("picture length${selectedImages.length}");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        foregroundColor: white,
        centerTitle: true,
        title: TextWidget(
          content: "Add Dream Destination",
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: InkWell(
                        onTap: pickPlaceImages,
                        child: Container(
                          width: double.infinity,
                          height: 210,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: selectedImages.isNotEmpty
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.file(
                                    File(selectedImages[displayImage]),
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Center(
                                  child: Icon(
                                    Icons.add_a_photo,
                                    size: 30,
                                    color: Colors.grey[600],
                                  ),
                                ),
                        )),
                  ),
                  selectedImages.isNotEmpty
                      ? Container(
                          height: 100,
                          width: double.infinity,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: selectedImages.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        displayImage = index;
                                      });
                                    },
                                    child: Container(
                                      width: 100.w,
                                      height: 80.h,
                                      decoration: BoxDecoration(
                                          color: green,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          image: DecorationImage(
                                              image: FileImage(File(
                                                selectedImages[index],
                                              )),
                                              fit: BoxFit.cover)),
                                    ),
                                  ),
                                );
                              }))
                      : SizedBox()
                ],
              ),
              SizedBox(
                height: 20,
              ),
              newTextFeild(
                labelText: "Destination Name",
                controller: _destinationController,
                keyboardType: TextInputType.name,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "please enter the destination name";
                  }
                  return null;
                },
              ),
              newTextFeild(
                labelText: "Total Amount",
                controller: _totalExpenseController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "please enter total amount";
                  }
                  return null;
                },
              ),
              newTextFeild(
                labelText: "Total Savigns",
                controller: _totalSavingsController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "please enter total saving";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Visibility(
        visible: MediaQuery.of(context).viewInsets.bottom == 0.0,
        child: Container(
          color: white,
          height: 80,
          child: Center(
            child: PrimaryButton(
                backgroundColor: primaryColor,
                content: TextWidget(
                    content: "Add Destination",
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                width: 250,
                height: 50,
                onPressed: () async {
                  if (selectedImages.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: red,
                        content: TextWidget(
                          content: "please select the place images",
                          fontSize: 15,
                          
                          fontWeight: FontWeight.bold,
                          color: white,
                        )));
                  } else if (_formKey.currentState!.validate()) {
                    final destinationName = _destinationController.text;
                    final totalExpense =
                        double.tryParse(_totalExpenseController.text) ?? 0;
                    final totalSavings =
                        double.tryParse(_totalSavingsController.text) ?? 0;

                    final dreamDestinationData = DreamDestinationModel(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        userId: widget.userId.toString(),
                        destination: destinationName,
                        totalExpense: totalExpense,
                        totalSavings: totalSavings,
                        placeImage: selectedImages);
                    await addDreamPlace(destinationTrip: dreamDestinationData);
                    await dreamPlaceToList(userId: widget.userId.toString());
                    if (mounted) {
                      setState(() {});
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                    }
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: green,
                        content: TextWidget(
                          content: "Your dream destination succsessfully added",
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: white,
                        )));
                  }
                }),
          ),
        ),
      ),
    );
  }

  Future<void> pickPlaceImages() async {
    final pickedImages = await ImagePicker().pickMultiImage();

    await Future.forEach(
        pickedImages, (elements) => selectedImages.add(elements.path));

    setState(() {
      selectedImages = selectedImages;
    });
  }
}
