import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_travelo_app/constants/constable.dart';
import 'package:my_travelo_app/Models/singInModel.dart';
import 'package:my_travelo_app/Views/Screens/Trip_Screens/Add_Trip_screens/Add_Trip/pages/add_trip_screen.dart';
import 'package:my_travelo_app/Views/Screens/Primary_Screens/Favorite/Pages/favorite_screen.dart';
import 'package:my_travelo_app/Views/Screens/Primary_Screens/Home/pages/home_screens.dart';
import 'package:my_travelo_app/Views/Screens/Primary_Screens/Profile/Pages/profile_screen.dart';
import 'package:my_travelo_app/Views/Screens/Primary_Screens/Schedule/Pages/schedule_screen.dart';
import 'package:get/get.dart';

class Dashboard extends StatefulWidget {
  final Singinmodel? userDetails;
  const Dashboard({
    super.key,
    this.userDetails,
  });

  @override
  State<Dashboard> createState() => _DashboardState();
}

final PageStorageBucket bucket = PageStorageBucket();

Widget currentScreen = const Homescreen();

class _DashboardState extends State<Dashboard> {
  int currentPageIndex = 0;
  late List<Widget> screens;
  @override
  void initState() {
    super.initState();
    List<Widget> screens = [
      const Homescreen(),
      const ScheduleScreen(),
      const FavoriteScreen(),
      const Profilescreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(bucket: bucket, child: currentScreen),
      floatingActionButton: Visibility(
        visible: MediaQuery.of(context).viewInsets.bottom == 0.0,
        child: FloatingActionButton(
          backgroundColor: primaryColor,
          shape: const CircleBorder(),
          onPressed: () {
            // Navigator.of(context).push(MaterialPageRoute(
            //   builder: (context) => const AddTripScreens(),
            // ));
            Get.to(() => const AddTripScreens(),
                transition: Transition.fade,
                duration: const Duration(seconds: 1));
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: SizedBox(
          height: 30.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        currentScreen = const Homescreen();
                        currentPageIndex = 0;
                      });
                    },
                    icon: Icon(
                      Icons.home,
                      color:
                          currentPageIndex == 0 ? primaryColor : secondaryColor,
                      size: 28.w,
                    ),
                  ),
                   SizedBox(
                    width: 22.w,
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        currentScreen = const ScheduleScreen();
                        currentPageIndex = 1;
                      });
                    },
                    icon: FaIcon(
                      FontAwesomeIcons.list,
                      size: 24.w,
                      color:
                          currentPageIndex == 1 ? primaryColor : secondaryColor,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        currentScreen = const FavoriteScreen();
                        currentPageIndex = 2;
                      });
                    },
                    icon: Icon(
                      Icons.favorite,
                      size: 26.w,
                      color:
                          currentPageIndex == 2 ? primaryColor : secondaryColor,
                    ),
                  ),
                   SizedBox(
                    width: 20.w,
                  ),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          currentScreen = const Profilescreen(
                              // userDetails: widget.userDetails,
                              );
                          currentPageIndex = 3;
                        });
                      },
                      icon: Icon(
                        Icons.person_2_rounded,
                        size: 30.w,
                        color: currentPageIndex == 3
                            ? primaryColor
                            : secondaryColor,
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
