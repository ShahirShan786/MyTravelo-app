import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_travelo_app/constants/constable.dart';

 typedef String? ValidatorFunction(String? value);

class Textformfeilds extends StatelessWidget {



  TextEditingController? controller ;
  String? labelText;
  Color? labelColor;
  Widget? suffics;
 final ValidatorFunction? validator;

 Textformfeilds({super.key, 
    this.controller,
    this.labelColor,
    this.labelText,
    this.suffics,
    this.validator
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      
                        controller: controller,
                        decoration:  InputDecoration(
                          labelText: labelText,
                          labelStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: labelColor),
                          suffixIcon: suffics,
                          enabledBorder:const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: primaryColor, width: 2)),
                          errorBorder:const UnderlineInputBorder(
                              borderSide: BorderSide(color: primaryColor)),
                          focusedErrorBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: primaryColor)),
                        ),
                        validator: validator,
                      );
  }
}