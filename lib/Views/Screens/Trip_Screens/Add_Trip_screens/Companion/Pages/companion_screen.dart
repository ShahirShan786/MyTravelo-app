import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

import 'package:My Travelo/Views/Screens/Widgets/show_dialogues.dart';
import 'package:My Travelo/constants/constable.dart';
import 'package:My Travelo/constants/constant.dart';
import 'package:My Travelo/constants/primary_button.dart';
import 'package:My Travelo/Views/Screens/Trip_Screens/Add_Trip_screens/Trip_Plan/Pages/trip_plan_screen.dart';

class CompanionScreen extends StatefulWidget {
  final String destination;
  final DateTime selectedRangeStart;
  final DateTime selectedRangeEnd;
  final String finalSelectTime;
  const CompanionScreen({
    super.key,
    required this.destination,
    required this.selectedRangeStart,
    required this.selectedRangeEnd,
    required this.finalSelectTime,
  });

  @override
  State<CompanionScreen> createState() => _CompanionScreenState();
}

class _CompanionScreenState extends State<CompanionScreen> {
  List<Contact> selectedContacts = [];

  Future<List<Contact>> getContacts() async {
    if (await FlutterContacts.requestPermission()) {
      return await FlutterContacts.getContacts(withProperties: true);
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              children: [
                SizedBox(height: 20.h),
                TextWidget(
                  content: "Invite your tripmates",
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: 20.h),
                TextWidget(
                  content: "Plan with your friends: your changes sync in",
                  fontSize: 17.sp,
                  color: secondaryColor,
                  fontWeight: FontWeight.w600,
                ),
                TextWidget(
                  content: "real-time, keeping everyone in the loop",
                  fontSize: 17.sp,
                  color: secondaryColor,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(height: 20.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextWidget(
                    content: "Companions",
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 30.h),
                Expanded(
                  child: ListView.builder(
                    itemCount: selectedContacts.length,
                    itemBuilder: (context, index) {
                      final contact = selectedContacts[index];
                      return Padding(
                        padding: EdgeInsets.all(5.w),
                        child: ListTile(
                          title: Text(contact.displayName ?? "No Name"),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Container(
        color: Colors.white,
        height: 140.h,
        width: double.infinity,
        child: Column(
          children: [
            TextButton(
              onPressed: () async {
                showLoadingDialogue(
                    context: context, content: "Loading, please wait...");
                List<Contact> contacts = await getContacts();
                Navigator.of(context).pop();

                // Show a simple picker dialog
                Contact? picked = await showDialog(
                  context: context,
                  builder: (context) {
                    return SimpleDialog(
                      title: Text("Select a contact"),
                      children: contacts.map((contact) {
                        return SimpleDialogOption(
                          child: Text(contact.displayName ?? "No Name"),
                          onPressed: () {
                            Navigator.pop(context, contact);
                          },
                        );
                      }).toList(),
                    );
                  },
                );

                if (picked != null && !selectedContacts.contains(picked)) {
                  selectedContacts.add(picked);
                  setState(() {});
                  log('SelectedContacts length: ${selectedContacts.length}');
                }
              },
              child: TextWidget(
                content: "Invite tripmate",
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 5.h),
            PrimaryButton(
              backgroundColor: primaryColor,
              content: TextWidget(
                content: "Next",
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
              ),
              width: 250.w,
              height: 45.h,
              onPressed: () {
                if (selectedContacts.isNotEmpty) {
                  Get.to(
                    () => TripPlanScreen(
                      destination: widget.destination,
                      finalSelectTime: widget.finalSelectTime,
                      selectedRangeEnd: widget.selectedRangeEnd,
                      selectedRangeStart: widget.selectedRangeStart,
                      selectedContacts: selectedContacts,
                    ),
                    transition: Transition.rightToLeft,
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: red,
                      content: TextWidget(
                        content: "Please select your companion",
                        fontSize: 15.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
