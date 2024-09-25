import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_travelo_app/Controller/Firebase/firebase_functions.dart';
import 'package:my_travelo_app/Views/Screens/Sub_Screens/dream_destination_screen.dart';
import 'package:my_travelo_app/Views/Screens/Sub_Screens/place_details_screen.dart';
import 'package:my_travelo_app/Views/Screens/Widgets/app_bar.dart';
import 'package:my_travelo_app/constants/constable.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:my_travelo_app/Models/admin_model.dart';
import 'package:my_travelo_app/Views/Screens/Trip_Screens/Add_Trip_screens/Add_Trip/pages/add_trip_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final FireStoreServices fireStoreServices = FireStoreServices();
  List<String> homePictures = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadHomepictureUrl();
    fireStoreServices.getFirebaseDetails();
  }

  void loadHomepictureUrl() async {
    final imageUrl = await fireStoreServices.getImageUrls();
    if (mounted) {
      setState(() {
        homePictures = imageUrl;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Fetch screen size using MediaQuery
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: buildAppBar(screenWidth),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : buildSliderCarousel(screenHeight),
              const SizedBox(height: 10), // Remove screenutil-based height
              Padding(
                padding: EdgeInsets.only(left: screenWidth * 0.03),
                child: Text(
                  "Featured guides from users",
                  style: TextStyle(
                    fontSize:
                        screenWidth * 0.04, // Adjust for responsive font size
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              buildFeaturedPlaces(screenHeight, screenWidth),
            ],
          ),
        ),
      ),
    );
  }

  // Widget for the app bar
  PrimaryAppBar buildAppBar(double screenWidth) {
    return PrimaryAppBar(
      backgroundColors: BoxColor,
      leadingsWidth: screenWidth * 0.1,
      leadings: Padding(
        padding: EdgeInsets.only(left: screenWidth * 0.02),
        child: Center(
          child: Text(
            "MyTravelo",
            style: TextStyle(
              color: primaryColor,
              fontSize: screenWidth * 0.01, // Adjust font size
              fontWeight: FontWeight.w600,
              fontFamily: "HeaderFont",
            ),
          ),
        ),
      ),
      actions: [
        IconButton(
          onPressed: () async {
            SharedPreferences prefz = await SharedPreferences.getInstance();
            final userId = prefz.getString("currentuserId");
            Get.to(() => DreamDestinationScreen(userId: userId.toString()));
          },
          icon: Icon(
            Icons.public,
            size: screenWidth * 0.03, // Responsive icon size
            color: primaryColor,
          ),
        ),
      ],
    );
  }

  // Widget for the image slider
  Widget sliderWidget(String urlImage) {
    return Container(
      color: Colors.grey.shade600,
      width: double.infinity,
      child: CachedNetworkImage(
        imageUrl: urlImage,
        fit: BoxFit.fill,
        width: double.infinity,
      ),
    );
  }

  // Slider Carousel Widget
  Widget buildSliderCarousel(double screenHeight) {
    return Stack(
      children: [
        CarouselSlider.builder(
          itemCount: homePictures.length,
          itemBuilder: (BuildContext context, int index, int realIndex) {
            final urlImage = homePictures[index];
            return sliderWidget(urlImage);
          },
          options: CarouselOptions(
            height: screenHeight * 0.7, // Adjust height based on screen size
            autoPlay: true,
            viewportFraction: 1.0,
          ),
        ),
        Positioned(
          bottom: screenHeight * 0.12,
          left: 15,
          child: Text(
            "Plan your next  \nadventure",
            style: TextStyle(
              color: Colors.white,
              fontSize: screenHeight * 0.07,
              fontWeight: FontWeight.w700,
              fontFamily: "MainFont",
            ),
          ),
        ),
        Positioned(
          bottom: screenHeight * 0.05,
          left: 15,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
            ),
            onPressed: () {
              Get.to(() => const AddTripScreens());
            },
            child: Text(
              "Create new trip plan",
              style: TextStyle(
                color: Colors.white,
                fontSize: screenHeight * 0.02,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Widget for the list of featured places
  Widget buildFeaturedPlaces(double screenHeight, double screenWidth) {
    return SizedBox(
      height: screenHeight * 0.65,
      width: double.infinity,
      child: ValueListenableBuilder(
        valueListenable: placeModelListener,
        builder: (context, value, child) {
          if (placeModelListener.value.isEmpty) {
            return const Center(
              child: Text("No places Available"),
            );
          } else {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: placeModelListener.value.length,
              itemBuilder: (BuildContext context, int index) {
                PlaceModel place = placeModelListener.value[index];
                return buildPlaceCard(place, index, screenWidth, screenHeight);
              },
            );
          }
        },
      ),
    );
  }

  // Widget for individual place card
  Widget buildPlaceCard(
      PlaceModel place, int index, double screenWidth, double screenHeight) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: GestureDetector(
        onTap: () {
          Get.to(
            () => PlaceDetailsScreen(index: index),
            transition: Transition.native,
          );
        },
        child: Container(
          width: screenWidth * 0.5,
          decoration: BoxDecoration(
            color: ScaffoldColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: place.subImage[0],
                  fit: BoxFit.cover,
                  height: screenHeight * 0.3,
                  width: double.infinity,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(
                      color: primaryLight,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, top: 4),
                child: Text(
                  place.place,
                  style: TextStyle(
                    fontSize: screenWidth * 0.03,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Text(
                  place.details,
                  style: TextStyle(
                    fontSize: screenWidth * 0.020,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
