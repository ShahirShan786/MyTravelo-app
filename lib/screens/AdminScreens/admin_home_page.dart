import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_travelo_app/Functions/firebase_functions.dart';
import 'package:my_travelo_app/SubScreens/place_detailes_page.dart';
import 'package:my_travelo_app/constants/constable.dart';
import 'package:my_travelo_app/constants/constant.dart';
import 'package:my_travelo_app/models/admin_model.dart';
import 'package:my_travelo_app/screens/AdminScreens/admin_addPlace_screen.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  FireStoreServices fireStoreServices = FireStoreServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fireStoreServices.getFirebaseDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: TextWidget(
            content: "Admin Pannel", fontSize: 20, fontWeight: FontWeight.bold),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "    Explore",
              style: TextStyle(fontSize: 35),
            ),
            SizedBox(
              height: 20,
            ),
            ValueListenableBuilder(
              valueListenable: placeModelListener,
              builder: (context, value, child) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: placeModelListener.value.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 5,
                        childAspectRatio: 0.7,
                        crossAxisSpacing: 5),
                    itemBuilder: (context, index) {
                      PlaceModel place = placeModelListener.value[index];
                      return InkWell(
                        onTap: () { 
                        },
                        onLongPress: () async {
                          showDialog(
                              context: context,
                              builder: (
                                context,
                              ) {
                                return AlertDialog(
                                  title: TextWidget(
                                      content: "Delete",
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                  content: TextWidget(
                                      content:
                                          "Are you sure you want to delete this place?",
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text("Cancel")),
                                    TextButton(
                                        onPressed: () async {
                                          await fireStoreServices.deletePlace(
                                              id: place.id);
                                          Navigator.of(context).pop();
                                        },
                                        child: Text("Delete")),
                                  ],
                                );
                              });
                        },
                        child: Container(
                          width: 220.w,
                          decoration: BoxDecoration(
                              color: ScaffoldColor,
                              borderRadius: BorderRadius.circular(10.r)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 145,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.r),
                                  child: Image.network(
                                    place.mainImage,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 5.w),
                                child: TextWidget(
                                    content: place.place,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5),
                                child: Text(
                                  place.details,
                                  style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w500),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 4,
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AdminAddPlaceScreen(),
          ));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
