import 'dart:developer';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_travelo_app/Controller/Firebase/firebase_functions.dart';
import 'package:my_travelo_app/Controller/Hive/image_upload.dart';
import 'package:my_travelo_app/Views/Screens/Widgets/admin_textfeild.dart';
import 'package:my_travelo_app/Views/Screens/Widgets/show_dialogues.dart';
import 'package:my_travelo_app/constants/constable.dart';
import 'package:my_travelo_app/constants/constant.dart';
import 'package:my_travelo_app/constants/primary_button.dart';
import 'package:my_travelo_app/Models/admin_model.dart';
import 'package:my_travelo_app/Views/Admin-screens/Home_Page/Pages/admin_home_page.dart';

class AdminEditPlaceScreen extends StatefulWidget {
  final PlaceModel? firebasePlaceModel;
  final int? index;
  const AdminEditPlaceScreen(
      {super.key, required this.firebasePlaceModel, required this.index});

  @override
  State<AdminEditPlaceScreen> createState() => _AdminEditPlaceScreenState();
}

class _AdminEditPlaceScreenState extends State<AdminEditPlaceScreen> {
  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();

  XFile? _image;
  List<XFile> _imageFiles = [];
  List<String> urlsOfImage = [];
  String? urlOfMainImage;

  final FireStoreServices fireStoreServices = FireStoreServices();

  final CollectionReference places =
      FirebaseFirestore.instance.collection("Places");

  @override
  Widget build(BuildContext context) {
    List<String> firebaseImages = widget.firebasePlaceModel!.subImage;
    log("======+++++=====${firebaseImages.length}");

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
                        borderRadius: BorderRadius.circular(15.r),
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
                Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding:  EdgeInsets.all(8.0.w),
                        child: InkWell(
                          onTap: pickSubImages,
                          child: Container(
                            width: 80.w,
                            height: 80.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              color: Colors.grey[200],
                            ),
                            child: const Center(
                              child: Icon(Icons.photo_library_sharp),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.all(8.0.w),
                      child: SizedBox(
                          height: 100,
                          child: _imageFiles.isNotEmpty
                              ? ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: _imageFiles.length,
                                  itemBuilder: (context, index) {
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
                                                    fontWeight:
                                                        FontWeight.bold),
                                                content: TextWidget(
                                                    content:
                                                        "Are you sure you want to delete this image?",
                                                    fontSize: 14.sp,
                                                    fontWeight:
                                                        FontWeight.normal),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child:
                                                          const Text("Cancel")),
                                                  TextButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          _imageFiles
                                                              .removeAt(index);
                                                        });
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child:
                                                          const Text("Delete")),
                                                ],
                                              );
                                            });
                                      },
                                      child: Padding(
                                        padding:  EdgeInsets.all(5.0.w),
                                        child: SizedBox(
                                          width: 110.w,
                                          height: 80.h,
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10.r),
                                              child: Image.file(
                                                File(
                                                  _imageFiles[index].path,
                                                ),
                                                fit: BoxFit.fill,
                                              )),
                                        ),
                                      ),
                                    );
                                  })
                              : ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: firebaseImages.length,
                                  itemBuilder: (context, index) {
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
                                                    fontWeight:
                                                        FontWeight.bold),
                                                content: TextWidget(
                                                    content:
                                                        "Are you sure you want to delete this image?",
                                                    fontSize: 14.sp,
                                                    fontWeight:
                                                        FontWeight.normal),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child:
                                                          const Text("Cancel")),
                                                  TextButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          firebaseImages
                                                              .removeAt(index);
                                                        });
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child:
                                                          const Text("Delete")),
                                                ],
                                              );
                                            });
                                      },
                                      child: Padding(
                                        padding:  EdgeInsets.all(5.0.w),
                                        child: SizedBox(
                                          width: 110.w,
                                          height: 80.h,
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10.r),
                                              child: CachedNetworkImage(
                                                imageUrl: firebaseImages[index],
                                                fit: BoxFit.fill,
                                                placeholder: (context, url) =>
                                                    Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: indicatorColor,
                                                  ),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Center(
                                                  child:
                                                      Icon(Icons.error_outline),
                                                ),
                                              )),
                                        ),
                                      ),
                                    );
                                  })),
                    ),
                  ],
                ),
                Align(
                    alignment: Alignment.topLeft,
                    child: TextWidget(
                        content: "Place",
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold)),
                textField(
                    label: "Place name",
                    controller: _placeController,
                    text: widget.firebasePlaceModel?.place),
                Align(
                    alignment: Alignment.topLeft,
                    child: TextWidget(
                        content: "District",
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold)),
                textField(
                    label: "District",
                    controller: _districtController,
                    text: widget.firebasePlaceModel?.district),
                Align(
                    alignment: Alignment.topLeft,
                    child: TextWidget(
                        content: "Details",
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold)),
                textField(
                    label: "place details",
                    controller: _detailsController,
                    text: widget.firebasePlaceModel?.details),
                 SizedBox(
                  height: 10.h,
                ),
                PrimaryButton(
                    backgroundColor: primaryColor,
                    content: TextWidget(
                        content: "Update Details",
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold),
                    width: 250.w,
                    height: 50.h,
                    onPressed: () async {
                      if (_placeController.text.isEmpty ||
                          _districtController.text.isEmpty ||
                          _detailsController.text.isEmpty) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Fill all details"),
                          backgroundColor: red,
                        ));
                      } else {
                        showLoadingDialogue(
                            context: context, content: "Updating datas...");
                        urlsOfImage =
                            await uploadSubImages(images: _imageFiles);
                        fireStoreServices.updatePlace(
                            id: widget.firebasePlaceModel!.id,
                            place: _placeController.text,
                            district: _districtController.text,
                            details: _detailsController.text,
                            lattitude: widget.firebasePlaceModel!.lattitude,
                            longitude: widget.firebasePlaceModel!.longitude,
                            mainImage: widget.firebasePlaceModel!.mainImage,
                            images: urlsOfImage.isEmpty
                                ? firebaseImages
                                : urlsOfImage);
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).pop();
                      }
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => const AdminHomePage(),
                          ),
                          (Route<dynamic> route) => false);
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
