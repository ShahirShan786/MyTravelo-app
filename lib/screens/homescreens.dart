import 'package:flutter/material.dart';
import 'package:my_travelo_app/constants/constable.dart';
import 'package:my_travelo_app/constants/constant.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:my_travelo_app/listes/places_list.dart';
import 'package:my_travelo_app/sub_Screens/place_detailes_page.dart';

class Homescreen extends StatefulWidget {
  Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  Widget SliderWidget(String urlImage, int index) {
    return Container(
      color: Colors.grey.shade600,
      width: double.infinity,
      child: Image.network(
        urlImage,
        fit: BoxFit.fill,
        width: double.infinity,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Center(
              child: TextWidget(
                color: primaryColor,
                content: "MyTravelo",
                fontSize: 19,
                fontWeight: FontWeight.w600,
                fontFamily: "HeaderFont",
              ),
            ),
          ),
          leadingWidth: 120,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    CarouselSlider.builder(
                        itemCount: imageItems.length,
                        itemBuilder:
                            (BuildContext context, int index, int realIndex) {
                          final urlImage = imageItems[index];
                          return SliderWidget(urlImage, index);
                        },
                        options: CarouselOptions(
                            height: 350,
                            autoPlay: true,
                            viewportFraction: 1.0)),
                    Positioned(
                      bottom: 85,
                      left: 15,
                      child: TextWidget(
                        color: Colors.white,
                        content: "Plan your next  \nadventure",
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        fontFamily: "MainFont",
                      ),
                    ),
                    Positioned(
                      bottom: 30,
                      left: 15,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                        ),
                        onPressed: () {},
                        child: TextWidget(
                            color: Colors.white,
                            content: "Create new trip plan",
                            fontSize: 12,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: TextWidget(
                      content: "Featured guides from users",
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
                Container(
                  height: 260,
                  width: double.infinity,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: placeList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(4),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return PlaceDetailesPage(placeImg: placeList[index].placeImage, description: placeList[index].placeDescription, place: placeList[index].destination, placeName: placeList[index].placename,);
                            },));
                          },
                          child: Card(
                            child: Container(
                              width: 220,
                              height: 160,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      placeList[index].placeImage,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: TextWidget(
                                        content: placeList[index].placename,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Text(
                                      placeList[index].placeDescription,
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 4,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
