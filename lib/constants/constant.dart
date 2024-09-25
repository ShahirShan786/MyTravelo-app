

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TextWidget extends StatelessWidget {
  Color? color;
  String? content;
  double? fontSize;
  FontWeight? fontWeight;
  String? fontFamily;
  TextOverflow? textOverflow;

  TextWidget({
    super.key,
    this.color,
    required this.content,
    required this.fontSize,
    required this.fontWeight,
    this.fontFamily,
    this.textOverflow
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
        overflow: textOverflow,
        
      ),
    );
  }
}
