import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TextWidget extends StatelessWidget {
  Color? color;
  String? content;
  double? fontSize;
  FontWeight? fontWeight;
  String? fontFamily;

  TextWidget(
      {this.color,
      required this.content,
      required this.fontSize,
      required this.fontWeight,
      this.fontFamily,
      
      });

  @override
  Widget build(BuildContext context) {
    return Text(
      content!,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontFamily: fontFamily,
      ),
    );
  }
}
