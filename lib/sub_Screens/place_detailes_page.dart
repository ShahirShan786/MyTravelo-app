import 'package:flutter/material.dart';
import 'package:my_travelo_app/constants/constable.dart';
import 'package:my_travelo_app/constants/constant.dart';
import 'package:my_travelo_app/constants/primary_button.dart';
import 'package:my_travelo_app/listes/places_list.dart';
import 'package:my_travelo_app/sub_Screens/Widgets/picture_section.dart';

class PlaceDetailesPage extends StatelessWidget {
  String? placeImg;
  String? description;
  String? place;
  String? placeName;

  PlaceDetailesPage(
      {required this.placeImg,
      required this.description,
      required this.place,
      required this.placeName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Image.network(
                placeImg!,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2,
                fit: BoxFit.cover,
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 30, left: 15),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 60,
                      height: 30,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(127, 255, 255, 255),
                          borderRadius: BorderRadius.circular(20)),
                      child: Icon(Icons.arrow_back_outlined),
                    ),
                  )),
              Positioned(
                bottom: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 1.8,
                  decoration: BoxDecoration(
                    color: ScaffoldColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        PictureSection(),
                        SizedBox(height: 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextWidget(
                                content: placeName,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.favorite_border_rounded,
                                size: 30,
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 20,
                              color: secondaryColor,
                            ),
                            TextWidget(
                                content: place,
                                fontSize: 16,
                                color: secondaryColor,
                                fontWeight: FontWeight.normal),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: double.infinity,
                          height: 230,
                          child: SingleChildScrollView(
                            child: SizedBox(
                              child: Text(
                                description!,
                                maxLines: 30,
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
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
            onPressed: () {},
            height: 50,
            width: 250,
            backgroundColor: primaryColor,
          ),
        )),
      ),
    );
  }
}
