import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_travelo_app/Widgets/companion_card.dart';
import 'package:my_travelo_app/constants/constant.dart';
import 'package:my_travelo_app/screens/AddTripScreens/companion_screen.dart';
import 'package:my_travelo_app/screens/AddTripScreens/trip_plan_screen.dart';

class OptionScreen extends StatelessWidget {
  const OptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: TextWidget(
            content: "Travel Companions",
            fontSize: 20,
            fontWeight: FontWeight.bold),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: TextWidget(
                    content: "Select your travel group type",
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 60,
              ),
              CompanionCard(
                icon: FontAwesomeIcons.person,
                title: "Solo",
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => TripPlanScreen(),
                  ));
                },
              ),
              const SizedBox(
                height: 35,
              ),
              CompanionCard(
                icon: FontAwesomeIcons.peopleGroup,
                title: "Companion",
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CompanionScreen(),
                  ));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
