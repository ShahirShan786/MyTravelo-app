import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';

import 'package:my_travelo_app/constants/constable.dart';
import 'package:my_travelo_app/constants/constant.dart';
import 'package:my_travelo_app/dashboard.dart';
import 'package:my_travelo_app/models/profileModel.dart';
import 'package:my_travelo_app/models/singInModel.dart';
import 'package:my_travelo_app/profileSubScreen/TermsPage.dart';
import 'package:my_travelo_app/profileSubScreen/aboutPage.dart';
import 'package:my_travelo_app/profileSubScreen/logoutPAge.dart';
import 'package:my_travelo_app/profileSubScreen/privacy_page.dart';
import 'package:my_travelo_app/screens/homescreens.dart';
import 'package:my_travelo_app/screens/logIn_page.dart';
import 'package:my_travelo_app/servies/profileServies.dart';
import 'package:my_travelo_app/servies/signInService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profilescreen extends StatefulWidget {
  const Profilescreen({
    super.key,
  });

  @override
  State<Profilescreen> createState() => _ProfilescreenState();
}

class _ProfilescreenState extends State<Profilescreen> {
  List<Widget> profileScreens = [
    const Aboutpage(),
    const Privacypage(),
    const Termspage(),
    const Logoutpage()
  ];

  List<String> titles = ["About", "Privacy", "Terms", "Log out"];

  List<IconData> icons = [
    Icons.motion_photos_auto,
    Icons.lock,
    Icons.admin_panel_settings_rounded,
    Icons.logout_outlined
  ];

  final Signinservice _signinservice = Signinservice();

  List<Singinmodel>? profileDetails = [];

  Future<void> _loadProfileData() async {
    profileDetails = await _signinservice.getsignInData();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  File? pickedImage;
  File? selectedImage;

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: TextWidget(
          content: "Profile",
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                height: 110,
                decoration: BoxDecoration(
                    color: BoxColor, borderRadius: BorderRadius.circular(20)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: SizedBox(
                        width: 272,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    pickedImage = await getImage();

                                    setState(() {
                                      selectedImage = pickedImage;
                                    });
                                  },
                                  child: ClipOval(
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      child: selectedImage != null
                                          ? Image.file(
                                              selectedImage!,
                                              height: 150,
                                              width: 150,
                                              fit: BoxFit.cover,
                                            )
                                          : Image.network(
                                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR2ugjmkZZ-tnWNEZKCesBHKSRX2gEeX1zWeE9Iy26eoIrdcWG-oJ_XNvekGTrMbcEdy1M&usqp=CAU"),
                                      radius: 40,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 0,
                                  bottom: 2,
                                  child: Container(
                                    width: 25,
                                    height: 25,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle),
                                    child: Icon(
                                      Icons.add,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5, left: 12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextWidget(
                                      content: profileDetails != null &&
                                              profileDetails!.isNotEmpty
                                          ? profileDetails![0].username ?? " "
                                          : "User",
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  TextWidget(
                                      content: profileDetails != null &&
                                              profileDetails!.isNotEmpty
                                          ? profileDetails![0].email ?? "email"
                                          : "email",
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  TextWidget(
                                      content: profileDetails != null &&
                                              profileDetails!.isNotEmpty
                                          ? profileDetails![0].phone ?? "phone"
                                          : 'phone',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400)
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10, top: 10),
                      child: IconButton(
                          onPressed: () {},
                          icon: const FaIcon(
                            FontAwesomeIcons.pencil,
                            size: 20,
                          )),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                width: double.infinity,
                height: 450,
                decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                      itemCount: profileScreens.length,
                      itemBuilder: (BuildContext context, index) {
                        return ListTile(
                          leading: Icon(icons[index]),
                          title: TextWidget(
                              content: titles[index],
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                          trailing:
                              const Icon(Icons.arrow_forward_ios_outlined),
                          onTap: () {
                            if (index == profileScreens.length - 1) {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: TextWidget(
                                          content: "Log out",
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                      content: TextWidget(
                                          content:
                                              "Are you sure you want to logout ?",
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text("Cancel")),
                                        TextButton(
                                          onPressed: () async {
                                            Navigator.of(context)
                                                .pushAndRemoveUntil(
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          const LoginPage(),
                                                    ),
                                                    (Route<dynamic> route) =>
                                                        false);
                                            currentScreen = Homescreen();
                                            // currentPageIndex = 0;
                                            SharedPreferences prefs =
                                                await SharedPreferences
                                                    .getInstance();
                                            prefs.setBool("isLogedIn", false);
                                          },
                                          child: const Text("Log out"),
                                        )
                                      ],
                                    );
                                  });
                            } else {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => profileScreens[index],
                              ));
                            }
                          },
                        );
                      }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<File?> getImage() async {
    final pickImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickImage != null) {
      final picture = Singinmodel(image: pickImage.path);
      await _signinservice.addsignInData(picture);
      setState(() {
        selectedImage = File(pickImage.path);
      });
      return selectedImage;
    }
    return null;
  }

}
