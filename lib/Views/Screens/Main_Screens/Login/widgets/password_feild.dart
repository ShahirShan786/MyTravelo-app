import 'package:flutter/material.dart';
import 'package:my_travelo_app/Views/Screens/Widgets/textFormFeilds.dart';
import 'package:my_travelo_app/constants/constable.dart';

class buildPasswordFeild extends StatelessWidget {
  const buildPasswordFeild({
    super.key,
    required TextEditingController loginPasssword,
  }) : _loginPasssword = loginPasssword;

  final TextEditingController _loginPasssword;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 300),
      child: Textformfeilds(
        borderColor: Colors.red,
        focusedColor: primaryColor,
        keyboardType: TextInputType.visiblePassword,
        labelText: "Password",
        labelColor: secondaryColor,
        controller: _loginPasssword,
        obscureText: true,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please enter the password";
          }
          if (value.length < 6) {
            return "Password must be at least 6 characters long";
          }
          return null;
        },
      ),
    );
  }
}
