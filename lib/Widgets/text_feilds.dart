import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_travelo_app/constants/constable.dart';

class TExtFeilds extends StatelessWidget {
  String? labelText;
  String? hintText;
  TextEditingController? controller;

  TExtFeilds({
    required this.labelText,
    required this.hintText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: TextField(
          controller: controller,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
            hintText: hintText,
            hintStyle: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: secondaryColor),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
      ),
    );
  }
}
