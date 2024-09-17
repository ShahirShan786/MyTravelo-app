import 'dart:developer';

import 'package:contacts_service/contacts_service.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:my_travelo_app/Views/Screens/Widgets/multi_contact_picker.dart';
import 'package:my_travelo_app/Views/Screens/Widgets/show_dialogues.dart';
import 'package:my_travelo_app/constants/constable.dart';
import 'package:my_travelo_app/constants/constant.dart';
import 'package:my_travelo_app/constants/primary_button.dart';
import 'package:my_travelo_app/Views/Screens/Trip_Screens/Add_Trip_screens/Trip_Plan/Pages/trip_plan_screen.dart';
import 'package:permission_handler/permission_handler.dart';

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
  // List<Contact> contacts = [];
  Future<List<Contact>> getContacts() async {
    if (await Permission.contacts.request().isGranted) {
      return await ContactsService.getContacts();
    } else {
      return [];
    }
  }

  @override
  void initState() {
    super.initState();
    // if (selectedContact.isNotEmpty) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(left: 15.w, right: 15.w),
            child: Column(
              children: [
                SizedBox(
                  height: 20.h,
                ),
                TextWidget(
                    content: "Invite your tripmates",
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold),
                SizedBox(
                  height: 20.h,
                ),
                TextWidget(
                    content: "plan with your friends: your changes sync in",
                    fontSize: 17.sp,
                    color: secondaryColor,
                    fontWeight: FontWeight.w600),
                TextWidget(
                    content: "real-time,keeping everyone in the loop",
                    fontSize: 17.sp,
                    color: secondaryColor,
                    fontWeight: FontWeight.w600),
                SizedBox(
                  height: 20.h,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextWidget(
                      content: "Companions",
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    child: ListView.builder(
                        itemCount: selectedContacts.length,
                        itemBuilder: (BuildContext context, int index) {
                          final contactz = selectedContacts[index];
                          return Padding(
                              padding:  EdgeInsets.all(5.w),
                              child: ListTile(
                                title: Text(contactz.displayName ?? "No Name"),
                              ));
                        }),
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

                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pop();
                  await showDialog(
                    // ignore: use_build_context_synchronously
                    context: context,
                    builder: (context) => ContactPicker(
                      contacts: contacts,
                      selectedContacts: selectedContacts,
                    ),
                  );
                  log('SelectContacts length: ${selectedContacts.length}');
                  setState(() {});
                  // setState(() {
                  //   selectedContact.clear();
                  //   selectedContact.addAll(contacts.where((contact) =>
                  //       selectedContactId.contains(contact.identifier)));
                  // });
                },
                child: TextWidget(
                    content: "Invite tripmate",
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600)),
            SizedBox(
              height: 5.h,
            ),
            PrimaryButton(
                backgroundColor: primaryColor,
                content: TextWidget(
                    content: "Next",
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700),
                width: 250.w,
                height: 45.h,
                onPressed: () {
                  if (selectedContacts.isNotEmpty) {
                    // userSelectedContacts = selectedContact.toList();
                    log("userSelectContact length is :${selectedContacts.length}");
                    Get.to(
                        () => TripPlanScreen(
                              destination: widget.destination,
                              finalSelectTime: widget.finalSelectTime,
                              selectedRangeEnd: widget.selectedRangeEnd,
                              selectedRangeStart: widget.selectedRangeStart,
                              selectedContacts: selectedContacts,
                            ),
                        transition: Transition.rightToLeft);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: red,
                        content: TextWidget(
                          content: "Please select your companion",
                          fontSize: 15.sp,
                          fontWeight: FontWeight.normal,
                        )));
                  }
                }),
          ],
        ),
      ),
    );
  }
}
