
  import 'package:flutter/material.dart';
import 'package:my_travelo_app/Views/Screens/Widgets/textFormFeilds.dart';
import 'package:my_travelo_app/constants/constable.dart';

Textformfeilds BuildSignPhoneFeild(TextEditingController phoneController, GlobalKey<FormState> formkey) {
    return Textformfeilds(
                      borderColor: Colors.red,
                      focusedColor: primaryColor,
                      controller: phoneController,
                      keyboardType: TextInputType.number,
                      labelText: "Phone",
                      labelColor: secondaryColor,
                      textColor: formkey.currentState?.validate() == false
                          ? Colors.red
                          : Colors.black,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter phone number";
                        }
                        if (value.length != 10) {
                          return 'Enter a valid phone number';
                        }
                        return null;
                      },
                    );
  }
