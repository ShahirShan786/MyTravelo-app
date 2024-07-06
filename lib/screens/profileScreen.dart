import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_travelo_app/SectionScreens/addInfoScreen.dart';
import 'package:my_travelo_app/constants/constable.dart';
import 'package:my_travelo_app/constants/constant.dart';
import 'package:my_travelo_app/dashboard.dart';
import 'package:my_travelo_app/models/profileModel.dart';
import 'package:my_travelo_app/models/singInModel.dart';
import 'package:my_travelo_app/profileSubScreen/TermsPage.dart';
import 'package:my_travelo_app/profileSubScreen/aboutPage.dart';
import 'package:my_travelo_app/profileSubScreen/logoutPAge.dart';
import 'package:my_travelo_app/profileSubScreen/privacyPage.dart';
import 'package:my_travelo_app/screens/homescreens.dart';
import 'package:my_travelo_app/screens/logIn_page.dart';
import 'package:my_travelo_app/servies/profileServies.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profilescreen extends StatefulWidget {
  const Profilescreen({super.key, this.userDetails});
  final Singinmodel? userDetails;

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

  // final Profileservies _profileservies = Profileservies();

  Profilemodel? userProfile;
  String username = "";

  Future<void> getUsername() async {
    SharedPreferences prefsUsername = await SharedPreferences.getInstance();
    username = prefsUsername.getString("username") ?? ' ';
  }

  Future<void> _loadProfileData(String username) async {
    userProfile = await Profileservies().getProfileData(username);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getUsername().then(
      (value) {
        log('Username: $username');
        _loadProfileData(username);
      },
    );
  }

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
        actions: [
          InkWell(
            child: Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                  color: Colors.white,
                  // border: Border.all(color: Colors.grey.shade500),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade400,
                        spreadRadius: 1.5,
                        blurRadius: 2.5),
                  ],
                ),
                child: const Icon(Icons.add),
              ),
            ),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) => AddInfoScreen(
                      // userData: userProfile!,
                      )).then(
                (value) {
                  _loadProfileData(username);
                },
              );
            },
          )
        ],
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
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.network(
                                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR2ugjmkZZ-tnWNEZKCesBHKSRX2gEeX1zWeE9Iy26eoIrdcWG-oJ_XNvekGTrMbcEdy1M&usqp=CAU"),
                            ),
                            radius: 40,
                            // child: Image.asset(userProfile!.userImage!),
                            // child: userProfile!.userImage == null ?
                            //    Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR2ugjmkZZ-tnWNEZKCesBHKSRX2gEeX1zWeE9Iy26eoIrdcWG-oJ_XNvekGTrMbcEdy1M&usqp=CAU") :
                            //    Image.asset(userProfile!.userImage!),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15, top: 10),
                            child: TextWidget(
                                content: widget.userDetails!.username,
                                fontSize: 20,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
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
                                            currentPageIndex = 0;
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
}
