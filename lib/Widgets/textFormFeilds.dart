import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';




class Textformfeilds extends StatelessWidget {



  TextEditingController? controller ;
  String? labelText;
  Color? labelColor;
  Widget? suffics;
  Color? borderColor;
  Color? focusedColor;
  bool? obscureText;
final String? Function(String?)? validator;

 Textformfeilds({super.key, 
    this.controller,
    this.labelColor,
    this.labelText,
    this.suffics,
    this.validator,
    this.borderColor,
    this.focusedColor,
    this.obscureText = false,
    
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        obscureText: obscureText!,
                        controller: controller,
                        decoration:  InputDecoration(
                          labelText: labelText,
                          labelStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: labelColor),
                          suffixIcon: suffics,
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: borderColor!),
                          ),
                          focusedBorder:  UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: focusedColor!, width: 2)),
                          errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: focusedColor!)),
                          focusedErrorBorder:  UnderlineInputBorder(
                              borderSide: BorderSide(color: focusedColor!)),
                        ),
                        validator: validator,
                      );
  }
}