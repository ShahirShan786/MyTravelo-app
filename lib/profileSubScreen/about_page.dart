import 'package:flutter/material.dart';
import 'package:my_travelo_app/constants/constant.dart';

class Aboutpage extends StatelessWidget {
  const Aboutpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: TextWidget(
          content: "This is About page",
          fontSize: 17,
          fontWeight: FontWeight.w600),
    ));
  }
}
