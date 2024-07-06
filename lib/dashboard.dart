import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_travelo_app/constants/constable.dart';
import 'package:my_travelo_app/models/singInModel.dart';
import 'package:my_travelo_app/screens/addTrip_screens.dart';
import 'package:my_travelo_app/screens/favoriteScreen.dart';
import 'package:my_travelo_app/screens/homescreens.dart';
import 'package:my_travelo_app/screens/profileScreen.dart';
import 'package:my_travelo_app/screens/scheduleScreen.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key, this.userDetails});
  final Singinmodel? userDetails;

  @override
  State<Dashboard> createState() => _DashboardState();
}

int currentPageIndex = 0;
List<Widget> screens = [
  Homescreen(),
  Schedulescreen(),
  Favoritescreen(),
   Profilescreen(),
];

final PageStorageBucket bucket = PageStorageBucket();
Widget currentScreen = Homescreen();

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(bucket: bucket, child: currentScreen),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        shape: const CircleBorder(),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const AddTripScreens(),
          ));
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: SizedBox(
          height: 30,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        currentScreen = Homescreen();
                        currentPageIndex = 0;
                      });
                    },
                    icon: Icon(
                      Icons.home,
                      color:
                          currentPageIndex == 0 ? primaryColor : secondaryColor,
                      size: 28,
                    ),
                  ),
                  const SizedBox(
                    width: 22,
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        currentScreen = Schedulescreen();
                        currentPageIndex = 1;
                      });
                    },
                    icon: FaIcon(
                      FontAwesomeIcons.list,
                      size: 24,
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
                        currentScreen = Favoritescreen();
                        currentPageIndex = 2;
                      });
                    },
                    icon: Icon(
                      Icons.favorite,
                      size: 26,
                      color:
                          currentPageIndex == 2 ? primaryColor : secondaryColor,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          currentScreen = Profilescreen(
                            userDetails: widget.userDetails!,
                          );
                          currentPageIndex = 3;
                        });
                      },
                      icon: Icon(
                        Icons.person_2_rounded,
                        size: 30,
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
