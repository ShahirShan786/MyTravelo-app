import 'dart:developer';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_travelo_app/constants/constant.dart';


// List<String> selectedContactId = [];

class ContactPicker extends StatefulWidget {
  final List<Contact> contacts;
  final List<Contact> selectedContacts;
  const ContactPicker(
      {super.key, required this.contacts, required this.selectedContacts});

  @override
  State<ContactPicker> createState() => _ContactPickerState();
}

class _ContactPickerState extends State<ContactPicker> {
  List<String> tempSelectedContactId = [];
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding:  EdgeInsets.all(15.w),
      title: TextWidget(
          content: "Select Companion",
          fontSize: 22.sp,
          fontWeight: FontWeight.bold),
      content: SizedBox(
        width: double.maxFinite,
        height: 500.h,
        // color: Colors.grey[200],
        child: ListView.builder(
            itemCount: widget.contacts.length,
            itemBuilder: (BuildContext context, int index) {
              final contact = widget.contacts[index];
              // final contactId = contact.identifier ?? "";
              return ListTile(
                title: Text(contact.displayName ?? " "),
                leading: Checkbox(
                    checkColor: Colors.white,
                    activeColor: const Color(0xFF2196F3),
                    value: widget.selectedContacts.contains(contact),
                    onChanged: (bool? value) {
                      setState(() {
                        if (value == true) {
                          log('Contact name: ${contact.displayName}');
                          // selectedContactId.add(contactId);
                          widget.selectedContacts.add(contact);
                        } else {
                          // selectedContactId.remove(contactId);
                          // selectedContact
                          //     .removeWhere((c) => c.identifier == contactId);
                        }
                      });
                    }),
              );
            }),
        // color: Colors.yellow,
      ),
      actions: [
        TextButton(
            onPressed: () {
              // setState(() {
              //   selectedContactId.clear();
              //   selectedContactId.addAll(tempSelectedContactId);
              // });
              Navigator.of(context).pop();
            },
            child: TextWidget(
              content: "DISMISS",
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color:const Color.fromARGB(255, 74, 166, 77),
            )),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            // log("selectedContacts count :${selectedContact}");
          },
          child: TextWidget(
            content: "OK",
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 74, 166, 77),
          ),
        )
      ],
    );
  }
}
