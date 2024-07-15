import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_travelo_app/Widgets/textFormFeilds.dart';
import 'package:my_travelo_app/constants/constable.dart';
import 'package:my_travelo_app/constants/constant.dart';
import 'package:my_travelo_app/models/singInModel.dart';

import 'package:my_travelo_app/servies/signIn_service.dart';

class EditDialogue extends StatefulWidget {
  final Singinmodel user;

  const EditDialogue({required this.user});

  @override
  State<EditDialogue> createState() => _EditDialogueState();
}

class _EditDialogueState extends State<EditDialogue> {
  TextEditingController usernameEditController = TextEditingController();

  TextEditingController emailEditController = TextEditingController();

  TextEditingController phoneEditController = TextEditingController();

  final _editformKey = GlobalKey<FormState>();

 final Signinservice _signservies = Signinservice();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: TextWidget(
          content: "Edit Your Info", fontSize: 22, fontWeight: FontWeight.bold),
      content: SizedBox(
        width: 500,
        height: 230,
        child: Form(
          key: _editformKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 1, bottom: 1),
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
                padding: const EdgeInsets.only(top: 1, bottom: 1),
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
                padding: const EdgeInsets.only(top: 1, bottom: 1),
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
              content: "Cancel", fontSize: 15, fontWeight: FontWeight.w500),
        ),
        TextButton(
          onPressed: () {
            if (_editformKey.currentState!.validate()) {
              final updatedUser = Singinmodel(
                username: usernameEditController.text,
                email: emailEditController.text,
                phone: phoneEditController.text,
                id: widget.user.id,
                image: widget.user.image,
              );

              _signservies.updatesignInData(updatedUser);
              log("Data passed!!!!");
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
