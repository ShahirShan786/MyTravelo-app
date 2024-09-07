import 'package:flutter/material.dart';
import 'package:my_travelo_app/constants/constable.dart';

Widget newTextFeild({
  required String labelText,
  required TextEditingController controller,
  required TextInputType keyboardType,
  final String? Function(String?)? validator,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
    child: TextFormField(
      keyboardType: keyboardType,
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
            fontSize: 15, fontWeight: FontWeight.bold, color: Colors.grey[700]),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: purple, width: 2)),
      ),
      validator: validator,
    ),
  );
}
