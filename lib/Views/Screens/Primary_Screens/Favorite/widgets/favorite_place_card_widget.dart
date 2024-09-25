import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_travelo_app/Controller/Hive/user_functions.dart';
import 'package:my_travelo_app/Models/admin_model.dart';
import 'package:my_travelo_app/constants/constable.dart';
import 'package:my_travelo_app/constants/constant.dart';
import 'package:my_travelo_app/constants/primary_button.dart';

class buildFavePlaceCard extends StatelessWidget {
  const buildFavePlaceCard({
    super.key,
    required this.fav,
  });

  final PlaceModel fav;

  @override
  Widget build(BuildContext context) {
    // Get screen width and height using MediaQuery
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Card(
      child: Container(
        width: screenWidth, // Full screen width
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), // Fixed radius value
        ),
        child: Padding(
          padding: EdgeInsets.all(
              screenWidth * 0.01), // Padding as 1% of screen width
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15), // Fixed radius
                child: SizedBox(
                  width: screenWidth * 0.35, // 35% of screen width
                  height: screenHeight * 0.18, // 15% of screen height
                  child: CachedNetworkImage(
                    imageUrl: fav.subImage[0],
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(
                        color: primaryLight,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(screenWidth * 0.01),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      content: fav.place,
                      fontSize: screenWidth *
                          0.035, // 4.5% of screen width for font size
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(
                      height: screenHeight *
                          0.005, // Small gap between text and icon
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: screenWidth *
                              0.02, // Icon size as 4% of screen width
                        ),
                        TextWidget(
                          content: fav.district,
                          fontSize: screenWidth *
                              0.025, // Font size as 3.5% of screen width
                          fontWeight: FontWeight.normal,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PrimaryButton(
                          backgroundColor: primaryColor,
                          content: TextWidget(
                            content: "Direction",
                            fontSize: screenWidth *
                                0.025, // Adjusted button font size
                            fontWeight: FontWeight.normal,
                          ),
                          width: screenWidth * 0.05, // Adjusted button width
                          height: screenHeight * 0.04, // Adjusted button height
                          onPressed: () {
                            navigateToPlace(
                                lat: fav.lattitude, long: fav.longitude);
                          },
                        ),
                        SizedBox(
                          width:
                              screenWidth * 0.01, // Small gap between buttons
                        ),
                        PrimaryButton(
                          backgroundColor: primaryColor,
                          content: TextWidget(
                            content: "Remove",
                            fontSize: screenWidth *
                                0.025, // Adjusted button font size
                            fontWeight: FontWeight.normal,
                          ),
                          width: screenWidth * 0.05, // Adjusted button width
                          height: screenHeight * 0.04, // Adjusted button height
                          onPressed: () async {
                            await removeFevorite(fevoritePlace: fav.id);
                          },
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
