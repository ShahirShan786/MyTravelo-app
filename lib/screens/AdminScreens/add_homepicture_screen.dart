import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_travelo_app/Functions/firebase_functions.dart';
import 'package:my_travelo_app/Functions/image_upload.dart';
import 'package:my_travelo_app/Widgets/show_dialogues.dart';
import 'package:my_travelo_app/constants/constable.dart';
import 'package:my_travelo_app/constants/constant.dart';
import 'package:my_travelo_app/constants/primary_button.dart';

class AddHomePictureScreen extends StatefulWidget {
  const AddHomePictureScreen({super.key});

  @override
  State<AddHomePictureScreen> createState() => _AddHomePictureScreenState();
}

class _AddHomePictureScreenState extends State<AddHomePictureScreen> {
 final FireStoreServices _fireStoreServices = FireStoreServices();
  List<XFile> _homeImageFiles = [];
  List<String> getImageUrl = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: TextWidget(
                      content: "Add Home Page Pictures",
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              const  SizedBox(
                  height: 15,
                ),
                if (_homeImageFiles.isNotEmpty)
                  GridView.builder(
                    shrinkWrap: true,
                    physics:const NeverScrollableScrollPhysics(),
                    gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 3,
                        crossAxisSpacing: 3),
                    itemCount: _homeImageFiles.length,
                    itemBuilder: (context, index) {
                      return Container(
                          child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(
                          File(
                            _homeImageFiles[index].path,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ));
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 70),
        child: FloatingActionButton(
          onPressed: () {

            pickHomeImages();
          },
          child: const Icon(Icons.add),
        ),
      ),
      bottomSheet: Container(
        width: double.infinity,
        height: 70,
        color: white,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: PrimaryButton(
              content: TextWidget(
                content: "Add to Homepage",
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              onPressed: () async {
                showLoadingDialogue(context: context, content: "Adding data..");
                getImageUrl =
                    await uploadHomePicture(pictures: _homeImageFiles);
                if (_homeImageFiles.isEmpty) {
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("select the Home pictues"),
                    backgroundColor: red,
                  ));
                }
                 _fireStoreServices.addHomepictue(homePics: getImageUrl);
                Navigator.of(context).pop();
                 // ignore: use_build_context_synchronously
                 Navigator.of(context).pop();
                
              },
              height: 50,
              width: 250,
              backgroundColor: primaryColor,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> pickHomeImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> images = await picker.pickMultiImage();

    if (images != null) {
      setState(() {
        _homeImageFiles = images; // Directly assign the XFile list
      });
    }

    log("====${_homeImageFiles.length}");
  }
}
