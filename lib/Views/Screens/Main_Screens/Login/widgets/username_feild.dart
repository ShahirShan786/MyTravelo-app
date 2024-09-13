import 'package:flutter/material.dart';
import 'package:my_travelo_app/Views/Screens/Widgets/textFormFeilds.dart';
import 'package:my_travelo_app/constants/constable.dart';
// ignore: camel_case_types
class buildLogUsernameFeild extends StatelessWidget {
  const buildLogUsernameFeild({
    super.key,
    required TextEditingController loginUsername,
  }) : _loginUsername = loginUsername;

  final TextEditingController _loginUsername;

  @override
  Widget build(BuildContext context) {
    return Textformfeilds(
      borderColor: Colors.red,
      focusedColor: primaryColor,
      labelText: "Username",
      keyboardType: TextInputType.text,
      labelColor: secondaryColor,
      controller: _loginUsername,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter your username";
        }
        return null;
      },
    );
  }
}
