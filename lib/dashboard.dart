import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_travelo_app/constants/constable.dart';
import 'package:my_travelo_app/models/singInModel.dart';
import 'package:my_travelo_app/screens/AddTripScreens/add_trip_screen.dart';
import 'package:my_travelo_app/screens/favorite_screen.dart';
import 'package:my_travelo_app/screens/home_screens.dart';
import 'package:my_travelo_app/screens/profile_screen.dart';
import 'package:my_travelo_app/screens/schedule_screen.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key, this.userDetails});
 final Singinmodel? userDetails;

 
  @override
  State<Dashboard> createState() => _DashboardState();
}



final PageStorageBucket bucket = PageStorageBucket();
Widget currentScreen = Homescreen();

class _DashboardState extends State<Dashboard> {

int currentPageIndex = 0;
late List<Widget> screens;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    List<Widget> screens = [
       Homescreen(),
 const ScheduleScreen(),
 const FavoriteScreen(),
 const  Profilescreen(),
];
  }


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
                        currentScreen = const ScheduleScreen();
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
                        currentScreen =const FavoriteScreen();
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
                          currentScreen = const Profilescreen(
                            // userDetails: widget.userDetails,
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
