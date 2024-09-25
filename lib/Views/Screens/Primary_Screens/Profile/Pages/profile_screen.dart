import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_travelo_app/Controller/Hive/signIn_service.dart';
import 'package:my_travelo_app/Views/Screens/Primary_Screens/Profile/widgets/profile_info_section.dart';
import 'package:my_travelo_app/Views/Screens/Primary_Screens/Profile/widgets/settings_section.dart';
import 'package:my_travelo_app/Views/Screens/Widgets/app_bar.dart';
import 'package:my_travelo_app/Views/Screens/Widgets/edit_dialogue.dart';
import 'package:my_travelo_app/constants/constable.dart';
import 'package:my_travelo_app/Models/singInModel.dart';
import 'package:my_travelo_app/Views/Screens/Settings_Screens/Terms_page.dart';
import 'package:my_travelo_app/Views/Screens/Settings_Screens/about_page.dart';
import 'package:my_travelo_app/Views/Screens/Settings_Screens/logout_page.dart';
import 'package:my_travelo_app/Views/Screens/Settings_Screens/privacy_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profilescreen extends StatefulWidget {
  const Profilescreen({super.key});

  @override
  State<Profilescreen> createState() => _ProfilescreenState();
}

class _ProfilescreenState extends State<Profilescreen> {
  List<Widget> profileScreens = [
    const AboutPage(),
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

  Singinmodel? profileDetail;

  Future<void> _loadProfileData() async {
    SharedPreferences prefz = await SharedPreferences.getInstance();
    final currentUserId = prefz.getString("currentuserId");
    log("recieved currentuderId is :$currentUserId");
    if (currentUserId != null) {
      profileDetail = await _signinservice.getSignInDataById(currentUserId);
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  File? pickedImage;

  @override
  Widget build(BuildContext context) {
    // Get screen width and height using MediaQuery
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: const PrimaryAppBar(
        titles: "Profile",
        backgroundColors: BoxColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(
              screenWidth * 0.05), // 5% padding for responsiveness
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.02), // 2% height spacing
              Container(
                width: double.infinity,
                height: screenHeight * 0.18, // 15% of the screen height
                decoration: BoxDecoration(
                  color: BoxColor,
                  borderRadius: BorderRadius.circular(20), // Fixed radius value
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(screenWidth * 0.02), // 2% padding
                      child: SizedBox(
                        width: screenWidth * 0.2, // 70% of screen width
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    pickedImage = await getImage();
                                    setState(() {});
                                  },
                                  child: ClipOval(
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: screenWidth *
                                          0.05, // 10% of screen width
                                      child: pickedImage != null
                                          ? Image.file(
                                              pickedImage!,
                                              height: screenHeight *
                                                  0.06, // Adjusted image height
                                              width: screenWidth *
                                                  0.06, // Adjusted image width
                                              fit: BoxFit.cover,
                                            )
                                          : (profileDetail != null &&
                                                  profileDetail!.image != null)
                                              ? Image.file(
                                                  File(profileDetail!.image!),
                                                  height: screenHeight * 0.4,
                                                  width: screenWidth * 0.4,
                                                  fit: BoxFit.cover,
                                                )
                                              : Image.network(
                                                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR2ugjmkZZ-tnWNEZKCesBHKSRX2gEeX1zWeE9Iy26eoIrdcWG-oJ_XNvekGTrMbcEdy1M&usqp=CAU"),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: screenWidth * 0.02,
                                  bottom: screenHeight * 0.01,
                                  child: Container(
                                    width: screenWidth * 0.06,
                                    height: screenHeight * 0.03,
                                    decoration: const BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle),
                                    child: const Icon(Icons.add),
                                  ),
                                ),
                              ],
                            ),
                            ProfileInfoSection(profileDetail: profileDetail)
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        right: screenWidth * 0.02,
                        top: screenHeight * 0.01,
                      ),
                      child: IconButton(
                        onPressed: () async {
                          final updatedUser = await showDialog<Singinmodel>(
                            context: context,
                            builder: (context) =>
                                EditDialogue(user: profileDetail!),
                          );
                          if (updatedUser != null) {
                            setState(() {
                              profileDetail = updatedUser;
                            });
                          }
                        },
                        icon: FaIcon(
                          FontAwesomeIcons.pencil,
                          size: screenWidth *
                              0.02, // 5% of screen width for icon size
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              BuildSettingsSection(
                  profileScreens: profileScreens, icons: icons, titles: titles)
            ],
          ),
        ),
      ),
    );
  }

  Future<File?> getImage() async {
    final pickImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickImage != null && profileDetail != null) {
      profileDetail!.image = pickImage.path;
      await _signinservice.updatesignInData(profileDetail!);
      setState(() {
        pickedImage = File(pickImage.path);
      });
      return pickedImage;
    }
    return null;
  }
}
