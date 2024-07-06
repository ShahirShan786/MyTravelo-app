
import 'package:flutter/material.dart';
import 'package:my_travelo_app/constants/constant.dart';

class Favoritescreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: TextWidget(
          content: "This is Fevorite Screen",
          fontSize: 17,
          fontWeight: FontWeight.w600),
    ));
  }
}