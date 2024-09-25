
import 'package:flutter/material.dart';
import 'package:my_travelo_app/Views/Screens/Widgets/textFormFeilds.dart';
import 'package:my_travelo_app/constants/constable.dart';

class BuildSignEmailFeild extends StatelessWidget {
  const BuildSignEmailFeild({
    super.key,
    required this.emailController,
    required this.emailPattern,
  });

  final TextEditingController emailController;
  final String emailPattern;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 300),
      child: Textformfeilds(
        controller: emailController,
        labelText: "E-mail",
        keyboardType: TextInputType.emailAddress,
        labelColor: secondaryColor,
        borderColor: Colors.red,
        focusedColor: primaryColor,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please Enter an Email";
          }
          RegExp regex = RegExp(emailPattern);
          if (!regex.hasMatch(value)) {
            return "Enter a valid email address";
          }
      
          return null;
        },
      ),
    );
  }
}