import 'package:flutter/material.dart';
import 'package:my_travelo_app/Controller/Firebase/firebase_functions.dart';
import 'package:my_travelo_app/Controller/Hive/user_functions.dart';
import 'package:my_travelo_app/Views/Screens/Widgets/details_page_image.dart';
import 'package:my_travelo_app/constants/constable.dart';
import 'package:my_travelo_app/constants/primary_button.dart';

class PlaceDetailsScreen extends StatelessWidget {
  final int index;
  final bool fav;

  const PlaceDetailsScreen({super.key, required this.index, this.fav = false});

  @override
  Widget build(BuildContext context) {
    final place =
        fav ? fevoriteList.value[index] : placeModelListener.value[index];

    // Get screen size
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DetailsPageImage(
            place: place,
            context: context,
            isActive: true,
          ),
          Padding(
            padding: EdgeInsets.all(
                screenWidth * 0.02), // Adjusted for responsiveness
            child: Text(
              place.place,
              style: const TextStyle(
                fontSize: 25, // Adjust font size if needed
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
            child: Row(
              children: [
                const Icon(
                  Icons.location_on,
                  size: 20,
                  color: secondaryColor,
                ),
                Text(
                  place.district,
                  style: const TextStyle(
                    fontSize: 16,
                    color: secondaryColor,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.02, vertical: screenHeight * 0.01),
            child: SizedBox(
              width: double.infinity,
              height: screenHeight * 0.3, // Adjusted height for responsiveness
              child: SingleChildScrollView(
                child: Text(
                  place.details,
                  maxLines: 30,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        width: double.infinity,
        height: screenHeight * 0.1, // Adjusted height for responsiveness
        color: ScaffoldColor,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: PrimaryButton(
              content: const Text(
                "Go to Direction",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onPressed: () {
                navigateToPlace(lat: place.lattitude, long: place.longitude);
              },
              height: 50,
              width: 250,
              backgroundColor: primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
