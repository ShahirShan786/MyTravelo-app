import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_travelo_app/constants/constable.dart';
import 'package:my_travelo_app/constants/constant.dart';


class AddTripScreens extends StatelessWidget {
  const AddTripScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          Positioned(
              top: 50,
              left: 20,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[300], shape: BoxShape.circle),
                  width: 40,
                  height: 40,
                  child:const Icon(Icons.close),
                ),
              )),
          Center(
            child: Column(
              children: <Widget>[
              const  SizedBox(
                  height: 50,
                ),
                TextWidget(
                    content: "plan a new trip",
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              const  SizedBox(
                  height: 30,
                ),
                SizedBox(
                  child: Column(
                    children: [
                      TextWidget(
                          content: "Build an itinerary and map out your",
                          color: secondaryColor,
                          fontSize: 17,
                          fontWeight: FontWeight.w600),
                      TextWidget(
                          content: "upcoming travel plans",
                          color: secondaryColor,
                          fontSize: 17,
                          fontWeight: FontWeight.w600)
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
