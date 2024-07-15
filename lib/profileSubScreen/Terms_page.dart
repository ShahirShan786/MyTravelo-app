
import 'package:flutter/material.dart';
import 'package:my_travelo_app/constants/constant.dart';

class Termspage extends StatelessWidget {
  const Termspage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: TextWidget(
          content: "This is Terms page",
          fontSize: 17,
          fontWeight: FontWeight.w600),
    ));
  }
}