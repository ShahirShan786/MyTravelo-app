import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_travelo_app/constants/constant.dart';

class AddTripScreens extends StatelessWidget {
  const AddTripScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          Positioned(
            top: 50,
            left: 20,
            child: IconButton(onPressed: () {}, icon: Icon(Icons.close)),
          ),
          Center(
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                TextWidget(
                    content: "plan a new trip",
                    fontSize: 22,
                    fontWeight: FontWeight.bold)
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
