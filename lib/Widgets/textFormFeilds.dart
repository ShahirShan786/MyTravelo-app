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
  Color? textColor;
  Function()? ontap;

  TextInputType? keyboardType;
  
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
    this.keyboardType,
    this.textColor,
    this.ontap
    
    
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      
        obscureText: obscureText!,
                        controller: controller,
                        keyboardType: keyboardType,
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
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        style: TextStyle(
                          color: textColor
                        ),
                      onTap: ontap,
                      );
  }
}