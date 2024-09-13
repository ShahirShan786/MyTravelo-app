import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_travelo_app/Controller/Firebase/firebase_functions.dart';
import 'package:my_travelo_app/Controller/Hive/image_upload.dart';
import 'package:my_travelo_app/Views/Screens/Widgets/show_dialogues.dart';
import 'package:my_travelo_app/Views/Screens/Widgets/text_form_feild.dart';
import 'package:my_travelo_app/constants/constable.dart';
import 'package:my_travelo_app/constants/constant.dart';
import 'package:my_travelo_app/constants/primary_button.dart';
import 'package:my_travelo_app/Models/admin_model.dart';

class AdminAddPlaceScreen extends StatefulWidget {
 
  const AdminAddPlaceScreen({super.key,});

  @override
  State<AdminAddPlaceScreen> createState() => _AdminAddPlaceScreenState();
}

class _AdminAddPlaceScreenState extends State<AdminAddPlaceScreen> {
  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _latController = TextEditingController();
  final TextEditingController _logController = TextEditingController();

  XFile? _image;
  List<XFile> _imageFiles = [];
  List<String> urlsOfImage = [];
  String? urlOfMainImage;

  final FireStoreServices fireStoreServices = FireStoreServices();

  final CollectionReference places =
      FirebaseFirestore.instance.collection("Places");



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: TextWidget(
                      content: "Add main image",
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: pickMainImage,
                  child: Container(
                      width: 240,
                      height: 160,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: _image == null
                          ? const Center(
                              child: Icon(Icons.camera_alt_outlined),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                File(_image!.path),
                                fit: BoxFit.cover,
                              ))),
                ),
              const  SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: TextWidget(
                      content: "Add sub images",
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                _imageFiles.isEmpty
                    ? Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: pickSubImages,
                            child: Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[200],
                              ),
                              child:const Center(
                                child: Icon(Icons.photo_library_sharp),
                              ),
                            ),
                          ),
                        ),
                      )
                    :
                    Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: pickSubImages,
                            child: Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[200],
                              ),
                              child:const Center(
                                child: Icon(Icons.photo_library_sharp),
                              ),
                            ),
                          ),
                        ),
                      ),

                     Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Wrap(
                            spacing: 9,
                            runSpacing: 9,
                            children: _imageFiles.map((file) {
                              return InkWell(
                                onLongPress: () {
                                  showDialog(
                                      context: context,
                                      builder: (
                                        context,
                                      ) {
                                        return AlertDialog(
                                          title: TextWidget(
                                              content: "Delete",
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold),
                                          content: TextWidget(
                                              content:
                                                  "Are you sure you want to delete this image?",
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child:const Text("Cancel")),
                                            TextButton(
                                                onPressed: () {
                                                  setState(() {
                                                    _imageFiles.remove(file);
                                                  });
                                                  Navigator.of(context).pop();
                                                },
                                                child:const Text("Delete")),
                                          ],
                                        );
                                      });
                                },
                                child: SizedBox(
                                  width: 80,
                                  height: 80,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.file(
                                      File(file.path),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              );
                            }).toList()),
                      ),
                Align(
                    alignment: Alignment.topLeft,
                    child: TextWidget(
                        content: "Place",
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                TextFormFeild(
                  hintText: "Name of place",
                  controller: _placeController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the place name";
                    }
                    return null;
                  },
                ),
                Align(
                    alignment: Alignment.topLeft,
                    child: TextWidget(
                        content: "District",
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                TextFormFeild(
                  hintText: "destrict",
                  controller: _districtController,
                  
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the destination";
                    }
                    return null;
                  },
                ),
                Align(
                    alignment: Alignment.topLeft,
                    child: TextWidget(
                        content: "Lattitude Value",
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                TextFormFeild(
                  hintText: "lattutude value of the place",
                  controller: _latController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the lattitude";
                    }
                    return null;
                  },
                ),
                Align(
                    alignment: Alignment.topLeft,
                    child: TextWidget(
                        content: "Longitude Value",
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                TextFormFeild(
                  hintText: "longitude value of the place",
                  controller: _logController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the lattitude";
                    }
                    return null;
                  },
                ),
                Align(
                    alignment: Alignment.topLeft,
                    child: TextWidget(
                        content: "Details",
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                TextFormFeild(
                  maxLength: 4,
                  hintText: "details of the place",
                  controller: _detailsController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the destination";
                    }
                    return null;
                  },
                ),
              const  SizedBox(
                  height: 10,
                ),
                PrimaryButton(
                    backgroundColor: primaryColor,
                    content: TextWidget(
                        content: "Add Details",
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    width: 250,
                    height: 50,
                    onPressed: () async {
                      if (_placeController.text.isEmpty ||
                          _districtController.text.isEmpty ||
                          _latController.text.isEmpty ||
                          _logController.text.isEmpty ||
                          _detailsController.text.isEmpty) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Fill all details"),
                          backgroundColor: red,
                        ));
                      } else if (_image == null) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("select the main image"),
                          backgroundColor: red,
                        ));
                      } else if (_imageFiles.isEmpty) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("select the sub images"),
                          backgroundColor: red,
                        ));
                      } else {
                        showLoadingDialogue(context: context, content: "Adding data..");
                        urlOfMainImage = await uploadMainImage(image: _image);
                        urlsOfImage =
                            await uploadSubImages(images: _imageFiles);
                        final double lattitude =
                            double.parse(_latController.text);
                        final double longitude =
                            double.parse(_logController.text);
                        log("lattitude value is :$lattitude ");
                        log("longitude value is :$longitude");
                        
                        await fireStoreServices.addPlace(
                            place: _placeController.text,
                            district: _districtController.text,
                            details: _detailsController.text,
                            lattitude: lattitude,
                            longitude: longitude,
                            mainImage: urlOfMainImage!,
                            subImages: urlsOfImage);
                            Navigator.of(context).pop();
                      }
      
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pop();
                    }),
              const  SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> pickMainImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _image = XFile(pickedImage.path);
      });
    }
  }

  Future<void> pickSubImages() async {
    final ImagePicker picker = ImagePicker();

    final images = await picker.pickMultiImage();

    setState(() {
      _imageFiles = images;
    });
    }

  Future<void> showdeleteDailogue(int index) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: TextWidget(
                content: "Delete", fontSize: 22, fontWeight: FontWeight.bold),
            content: TextWidget(
                content: "Are you sure you want to delete this image?",
                fontSize: 14,
                fontWeight: FontWeight.normal),
          );
        });
  }
}
