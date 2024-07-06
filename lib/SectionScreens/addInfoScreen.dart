import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_travelo_app/constants/constant.dart';
import 'package:my_travelo_app/models/profileModel.dart';


class AddInfoScreen extends StatefulWidget {
  Profilemodel? userData;

  // AddInfoScreen({super.key, required this.userData});

  @override
  State<AddInfoScreen> createState() => _AddInfoScreenState();
}

class _AddInfoScreenState extends State<AddInfoScreen> {
  String emailPattern =
      r'^[a-zA-Z0-9.a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
  // final Profileservies _profileServies = Profileservies();
  final _profileKey = GlobalKey<FormState>();

  File? pickedImage;
  File? selectedImage;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: TextWidget(
          content: "Add your Information",
          fontSize: 20,
          fontWeight: FontWeight.bold),
      content: SingleChildScrollView(
        child: SizedBox(
          height: 400,
          child: Center(
            child: Form(
              key: _profileKey,
              child: Column(
                children: [
                  Stack(children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: CircleAvatar(
                        radius: 45,
                        backgroundImage: const NetworkImage(
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR2ugjmkZZ-tnWNEZKCesBHKSRX2gEeX1zWeE9Iy26eoIrdcWG-oJ_XNvekGTrMbcEdy1M&usqp=CAU"),
                        child: GestureDetector(
                            onTap: () async {
                              File? pickImage = await getimage();
                              setState(() {
                                selectedImage = pickImage;
                              });
                            },
                            child: selectedImage != null
                                ? ClipOval(
                                    child: Image.file(
                                        height: 150,
                                        width: 150,
                                        fit: BoxFit.cover,
                                        selectedImage!),
                                  )
                                : null),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      top: 0,
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: const BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle),
                          child: const Icon(
                            Icons.add,
                            weight: 200,
                          ),
                        ),
                      ),
                    ),
                  ]),
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                        label: TextWidget(
                            content: "Name",
                            fontSize: 15,
                            fontWeight: FontWeight.w500)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter a name";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                        label: TextWidget(
                            content: "E-mail",
                            fontSize: 15,
                            fontWeight: FontWeight.w500)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter an email";
                      }
                      RegExp regex = RegExp(emailPattern);
                      if (!regex.hasMatch(value)) {
                        return "Enter a valid email address";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    controller: phoneController,
                    decoration: InputDecoration(
                        label: TextWidget(
                            content: "Phone",
                            fontSize: 15,
                            fontWeight: FontWeight.w500)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter the phone number";
                      }
                      if (value.length < 10 || value.length > 10) {
                        return "Enter valid mobile number";
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      actions: [
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel")),
        ElevatedButton(
          onPressed: () async {
            if (_profileKey.currentState!.validate()) {
              if (selectedImage == null) {
                const imageErrorMessage = "You must select a profile picture";
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.red,
                    content: Text(
                      imageErrorMessage,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              }
              widget.userData!.name = nameController.text;
              widget.userData!.email = emailController.text;
              widget.userData!.phone = phoneController.text;
              widget.userData!.userImage = selectedImage?.path;

              // final profileDatas = Profilemodel(
              //   userName: widget.,
              //   name: profilename,
              //   email: profileEmail,
              //   phone: profilePhone,
              //   userImage: selectedImage?.path,
              // );

              // _profileServies.addProfileData(profileDatas);
              // _profileServies.updateProfileData(widget.userData.userName , widget.userData);

              Navigator.pop(context);
              log("Data fuction worked");
              nameController.clear();
              emailController.clear();
              phoneController.clear();
              setState(() {
                selectedImage = null;
              });
            }
          },
          child: const Text("Add"),
        ),
      ],
    );
  }

  // for pick image

  Future<File?> getimage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      return File(pickedImage.path);
    } else {
      return null;
    }
  }
}
