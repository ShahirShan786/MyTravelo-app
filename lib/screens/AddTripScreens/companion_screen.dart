import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:my_travelo_app/constants/constable.dart';
import 'package:my_travelo_app/constants/constant.dart';
import 'package:my_travelo_app/constants/primary_button.dart';
import 'package:my_travelo_app/screens/AddTripScreens/trip_plan_screen.dart';

class CompanionScreen extends StatefulWidget {
  const CompanionScreen({super.key});

  @override
  State<CompanionScreen> createState() => _CompanionScreenState();
}

class _CompanionScreenState extends State<CompanionScreen> {
  final FlutterContactPicker _contactPicker = FlutterContactPicker();
  Contact? _contact;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                TextWidget(
                    content: "Invite your tripmates",
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
                SizedBox(
                  height: 20,
                ),
                TextWidget(
                    content: "plan with your friends: your changes sync in",
                    fontSize: 17,
                    color: secondaryColor,
                    fontWeight: FontWeight.w600),
                TextWidget(
                    content: "real-time,keeping everyone in the loop",
                    fontSize: 17,
                    color: secondaryColor,
                    fontWeight: FontWeight.w600),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextWidget(
                      content: "Companions",
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 30,
                ),
                TextWidget(
                    content: "Name :${_contact?.fullName}",
                    fontSize: 15,
                    fontWeight: FontWeight.w600)
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Container(
        color: Colors.white,
        height: 140,
        width: double.infinity,
        child: Column(
          children: [
            TextButton(
                onPressed: () {
                  contactPicker();
                },
                child: TextWidget(
                    content: "Invite tripmate",
                    fontSize: 20,
                    fontWeight: FontWeight.w600)),
            SizedBox(
              height: 5,
            ),
            PrimaryButton(
                backgroundColor: primaryColor,
                content: TextWidget(
                    content: "Next", fontSize: 18, fontWeight: FontWeight.w700),
                width: 250,
                height: 45,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => TripPlanScreen(),
                  ));
                })
          ],
        ),
      ),
    );
  }

  Future<void> contactPicker() async {
    final contact = await _contactPicker.selectContact();
    if (contact != null) {
      setState(() {
        _contact = contact;
      });
    }
  }
}
