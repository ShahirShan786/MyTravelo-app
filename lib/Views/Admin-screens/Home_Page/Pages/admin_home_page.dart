import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:my_travelo_app/Controller/Firebase/firebase_functions.dart';
import 'package:my_travelo_app/Views/Admin-screens/Home_Page/widgets/home_picture_stream.dart';
import 'package:my_travelo_app/Views/Admin-screens/Home_Page/widgets/home_place_listanable.dart';
import 'package:my_travelo_app/constants/constant.dart';
import 'package:my_travelo_app/Views/Admin-screens/Home_picture/Pages/add_homepicture_screen.dart';
import 'package:my_travelo_app/Views/Admin-screens/Add_Place/pages/admin_addPlace_screen.dart';


class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  FireStoreServices fireStoreServices = FireStoreServices();
  List<Map<String, dynamic>> homePictures = [];
  @override
  void initState() {
    super.initState();
    fireStoreServices.getFirebaseDetails();
    _loadHomePictures();
  }

  Future<void> _loadHomePictures() async {
    homePictures = await fireStoreServices.getHomePictures();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: TextWidget(
            content: "Admin Pannel", fontSize: 20.sp, fontWeight: FontWeight.bold),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.all(8.0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:  EdgeInsets.symmetric(vertical: 10.h),
                child: TextWidget(
                    content: "Home Pictures",
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold),
              ),
              HomePictureStreem(fireStoreServices: fireStoreServices),
              Padding(
                padding:  EdgeInsets.only(top: 10.h, bottom: 5.h),
                child: TextWidget(
                    content: "Place Detailes",
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold),
              ),
              HomePlaceListenableBuilder(fireStoreServices: fireStoreServices)
            ],
          ),
        ),
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.add_event,
        children: [
          SpeedDialChild(
              onTap: () {
                Get.to(() => const AdminAddPlaceScreen());
              },
              child: const Icon(Icons.add_photo_alternate_outlined),
              label: "Add Place"),
          SpeedDialChild(
              onTap: () {
                Get.to(() => const AddHomePictureScreen());
              },
              child: const Icon(Icons.add_a_photo_outlined),
              label: "Add Home Pictures")
        ],
      ),
    );
  }
}




