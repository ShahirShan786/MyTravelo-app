import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_travelo_app/Controller/Hive/signIn_service.dart';
import 'package:my_travelo_app/Views/Screens/Widgets/textFormFeilds.dart';
import 'package:my_travelo_app/constants/constable.dart';
import 'package:my_travelo_app/constants/constant.dart';
import 'package:my_travelo_app/Models/singInModel.dart';



class EditDialogue extends StatefulWidget {
  final Singinmodel user;

  const EditDialogue({super.key, required this.user});

  @override
  State<EditDialogue> createState() => _EditDialogueState();
}

class _EditDialogueState extends State<EditDialogue> {
  late TextEditingController usernameEditController = TextEditingController();
  late TextEditingController emailEditController = TextEditingController();
  late TextEditingController phoneEditController = TextEditingController();

  final _editformKey = GlobalKey<FormState>();

  final Signinservice _signservies = Signinservice();

  @override
  void initState() {
    usernameEditController = TextEditingController(text: widget.user.username);
    emailEditController = TextEditingController(text: widget.user.email);
    phoneEditController = TextEditingController(text: widget.user.phone);
    super.initState();
  }

  @override
  void dispose() {
    usernameEditController.dispose();
    emailEditController.dispose();
    phoneEditController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: TextWidget(
          content: "Edit Your Info", fontSize: 22, fontWeight: FontWeight.bold),
      content: SizedBox(
        width: 500.w,
        height: 230.h,
        child: Form(
          key: _editformKey,
          child: Column(
            children: [
              Padding(
                padding:  EdgeInsets.only(top: 1.h, bottom: 1.h),
                child: Textformfeilds(
                  borderColor: Colors.black,
                  focusedColor: Colors.purple,
                  labelText: "Name",
                  labelColor: secondaryColor,
                  controller: usernameEditController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter the updated name";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(top: 1.h, bottom: 1.h),
                child: Textformfeilds(
                  borderColor: Colors.black,
                  focusedColor: Colors.purple,
                  controller: emailEditController,
                  labelColor: secondaryColor,
                  labelText: "Email",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter updated email";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(top: 1.h, bottom: 1.h),
                child: Textformfeilds(
                  borderColor: Colors.black,
                  focusedColor: Colors.purple,
                  labelText: "Phone",
                  labelColor: secondaryColor,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter updated phone";
                    }
                    return null;
                  },
                ),
              )
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: TextWidget(
              content: "Cancel", fontSize: 15.sp, fontWeight: FontWeight.w500),
        ),
        TextButton(
          onPressed: () async {
            if (_editformKey.currentState!.validate()) {
              final updatedUser = Singinmodel(
                username: usernameEditController.text,
                email: emailEditController.text,
                phone: phoneEditController.text,
                id: widget.user.id,
                image: widget.user.image,
              );
              log("Updated User Data :$updatedUser");

              await _signservies.updatesignInData(updatedUser);
              log("Data passed!!!!");

              final userAfterUpdate = await _signservies
                  .getSignInDataById(widget.user.id.toString());
              log("User Data After Updated :$userAfterUpdate");
              // ignore: use_build_context_synchronously
              Navigator.pop(context, updatedUser);
            }
          },
          child: TextWidget(
              content: "Save", fontSize: 15, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
