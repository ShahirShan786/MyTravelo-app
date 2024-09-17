import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_travelo_app/Controller/Firebase/firebase_functions.dart';
import 'package:my_travelo_app/Controller/Hive/image_upload.dart';
import 'package:my_travelo_app/Views/Admin-screens/Add_Place/widgets/details_text_field.dart';
import 'package:my_travelo_app/Views/Admin-screens/Add_Place/widgets/district_text_field.dart';
import 'package:my_travelo_app/Views/Admin-screens/Add_Place/widgets/lattitude_text_field.dart';
import 'package:my_travelo_app/Views/Admin-screens/Add_Place/widgets/logitude_text_field.dart';
import 'package:my_travelo_app/Views/Admin-screens/Add_Place/widgets/place_text_field.dart';
import 'package:my_travelo_app/Views/Screens/Widgets/show_dialogues.dart';
import 'package:my_travelo_app/Views/Screens/Widgets/text_form_feild.dart';
import 'package:my_travelo_app/constants/constable.dart';
import 'package:my_travelo_app/constants/constant.dart';
import 'package:my_travelo_app/constants/primary_button.dart';

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
          padding:  EdgeInsets.all(8.0.w),
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 50.h,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: TextWidget(
                      content: "Add main image",
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold),
                ),
                 SizedBox(
                  height: 20.h,
                ),
                InkWell(
                  onTap: pickMainImage,
                  child: Container(
                      width: 240.w,
                      height: 160.h,
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
                SizedBox(
                  height: 10.h,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: TextWidget(
                      content: "Add sub images",
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold),
                ),
                _imageFiles.isEmpty
                    ? Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding:  EdgeInsets.all(8.0.w),
                          child: InkWell(
                            onTap: pickSubImages,
                            child: Container(
                              width: 80.w,
                              height: 80.h,
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
                          padding:  EdgeInsets.all(8.0.sp),
                          child: InkWell(
                            onTap: pickSubImages,
                            child: Container(
                              width: 80.w,
                              height: 80.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
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
                        padding:  EdgeInsets.all(8.0.w),
                        child: Wrap(
                            spacing: 9.w,
                            runSpacing: 9.h,
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
                                              fontSize: 22.sp,
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
                                  width: 80.w,
                                  height: 80.h,
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
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold)),
                BuildPlaceTextFields(placeController: _placeController),
                Align(
                    alignment: Alignment.topLeft,
                    child: TextWidget(
                        content: "District",
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold)),
                BuildDistrictTextField(districtController: _districtController),
                Align(
                    alignment: Alignment.topLeft,
                    child: TextWidget(
                        content: "Lattitude Value",
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold)),
                BuildLattitudeTextField(latController: _latController),
                Align(
                    alignment: Alignment.topLeft,
                    child: TextWidget(
                        content: "Longitude Value",
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold)),
                BuildLogitudeTextField(logController: _logController),
                Align(
                    alignment: Alignment.topLeft,
                    child: TextWidget(
                        content: "Details",
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold)),
                BuildDetailsTextField(detailsController: _detailsController),
                SizedBox(
                  height: 10.h,
                ),
                PrimaryButton(
                    backgroundColor: primaryColor,
                    content: TextWidget(
                        content: "Add Details",
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold),
                    width: 250.w,
                    height: 50.h,
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
                SizedBox(
                  height: 10.h,
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
                fontSize: 14.sp,
                fontWeight: FontWeight.normal),
          );
        });
  }
}










