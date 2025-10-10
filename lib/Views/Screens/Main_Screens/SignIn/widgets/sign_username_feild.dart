import 'package:flutter/material.dart';
import 'package:MyTravelo/Views/Screens/Widgets/textFormFeilds.dart';
import 'package:MyTravelo/constants/constable.dart';

// ignore: camel_case_types
class buildSignUsernameFeild extends StatelessWidget {
  const buildSignUsernameFeild({
    super.key,
    required this.usernameController,
  });

  final TextEditingController usernameController;

  @override
  Widget build(BuildContext context) {
    return Textformfeilds(
      borderColor: Colors.red,
      focusedColor: primaryColor,
      controller: usernameController,
      labelText: "Username",
      keyboardType: TextInputType.text,
      labelColor: secondaryColor,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please Enter username";
        }

        return null;
      },
    );
  }
}
