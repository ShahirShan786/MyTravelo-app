import 'package:flutter/material.dart';
import 'package:my_travelo_app/constants/constant.dart';

class Schedulescreen extends StatelessWidget {
  Schedulescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: TextWidget(
          content: "This is Scheduled Screen",
          fontSize: 17,
          fontWeight: FontWeight.w600),
    ));
  }
}
