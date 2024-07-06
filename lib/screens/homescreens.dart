import 'package:flutter/material.dart';
import 'package:my_travelo_app/constants/constable.dart';
import 'package:my_travelo_app/constants/constant.dart';
import 'package:carousel_slider/carousel_slider.dart';

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
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
