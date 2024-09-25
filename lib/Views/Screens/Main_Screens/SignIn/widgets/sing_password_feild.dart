
  import 'package:flutter/material.dart';
import 'package:my_travelo_app/Views/Screens/Widgets/textFormFeilds.dart';
import 'package:my_travelo_app/constants/constable.dart';

Textformfeilds BuildSignPasswordFeild(TextEditingController passwordController) {
    return Textformfeilds(
                      borderColor: Colors.red,
                      focusedColor: primaryColor,
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      labelText: "Password",
                      labelColor: secondaryColor,
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
                    );
  }