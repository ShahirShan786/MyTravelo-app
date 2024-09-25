import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_travelo_app/Views/Screens/Main_Screens/Login/Pages/logIn_page.dart';
import 'package:my_travelo_app/Views/Screens/Primary_Screens/Home/pages/home_screens.dart';
import 'package:my_travelo_app/constants/constant.dart';
import 'package:my_travelo_app/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BuildSettingsSection extends StatelessWidget {
  const BuildSettingsSection({
    super.key,
    required this.profileScreens,
    required this.icons,
    required this.titles,
  });

  final List<Widget> profileScreens;
  final List<IconData> icons;
  final List<String> titles;

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions using MediaQuery
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      margin: EdgeInsets.only(top: screenHeight * 0.02), // 2% of screen height
      width: double.infinity,
      height: screenHeight * 0.55, // 55% of screen height for list height
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius:
            BorderRadius.circular(screenWidth * 0.05), // 5% of screen width
      ),
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.02), // 2% padding
        child: ListView.builder(
          itemCount: profileScreens.length,
          itemBuilder: (BuildContext context, index) {
            return ListTile(
              leading: Icon(icons[index]),
              title: TextWidget(
                content: titles[index],
                fontSize:
                    screenWidth * 0.02, // 5% of screen width for font size
                fontWeight: FontWeight.bold,
              ),
              trailing: const Icon(Icons.arrow_forward_ios_outlined),
              onTap: () {
                if (index == profileScreens.length - 1) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: TextWidget(
                          content: "Log out",
                          fontSize: screenWidth * 0.030, // 4.5% for dialog font
                          fontWeight: FontWeight.bold,
                        ),
                        content: TextWidget(
                          content: "Are you sure you want to logout?",
                          fontSize:
                              screenWidth * 0.017, // 3.7% for content text
                          fontWeight: FontWeight.w400,
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () async {
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (context) => const LoginPage(),
                                ),
                                (Route<dynamic> route) => false,
                              );
                              SharedPreferences prefz =
                                  await SharedPreferences.getInstance();
                              prefz.remove("currentuserId");

                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setBool("isLogedIn", false);

                              currentScreen = const Homescreen();
                            },
                            child: const Text("Log out"),
                          )
                        ],
                      );
                    },
                  );
                } else {
                  Get.to(() => profileScreens[index]);
                }
              },
            );
          },
        ),
      ),
    );
  }
}
