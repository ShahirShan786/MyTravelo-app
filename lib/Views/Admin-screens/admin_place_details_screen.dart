
import 'package:flutter/material.dart';
import 'package:my_travelo_app/Controller/Firebase/firebase_functions.dart';
import 'package:my_travelo_app/Controller/Hive/user_functions.dart';
import 'package:my_travelo_app/Views/Screens/Widgets/details_page_image.dart';
import 'package:my_travelo_app/constants/constable.dart';
import 'package:my_travelo_app/constants/constant.dart';
import 'package:my_travelo_app/constants/primary_button.dart';

class AdminPlaceDetailsScreen extends StatelessWidget {
  final index;
  const AdminPlaceDetailsScreen({super.key, this.index});
  
  @override
  Widget build(BuildContext context) {
    final place = placeModelListener.value[index];
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DetailsPageImage(
            place: place,
            context: context,
            isActive: false,
            index: index,
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextWidget(
                content: place.place,
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                const Icon(
                  Icons.location_on,
                  size: 20,
                  color: secondaryColor,
                ),
                TextWidget(
                    content: place.district,
                    fontSize: 16,
                    color: secondaryColor,
                    fontWeight: FontWeight.normal),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: SizedBox(
              width: double.infinity,
              height: 230,
              child: SingleChildScrollView(
                child: SizedBox(
                  child: Text(
                    place.details,
                    maxLines: 30,
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      bottomSheet: Container(
        width: double.infinity,
        height: 70,
        color: ScaffoldColor,
        child: Center(
            child: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: PrimaryButton(
            content: TextWidget(
                content: "Go to Direction",
                fontSize: 18,
                fontWeight: FontWeight.w600),
            onPressed: () {
                  navigateToPlace(lat: place.lattitude, long: place.longitude);
            },
            height: 50,
            width: 250,
            backgroundColor: primaryColor,
          ), 
        )),
      ),
    );
  }
}