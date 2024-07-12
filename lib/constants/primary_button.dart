// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_travelo_app/constants/constable.dart';

class PrimaryButton extends StatelessWidget {
  final Widget? content;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final VoidCallback? onPressed;

  PrimaryButton(
      {required this.content,
      required this.width,
      required this.height,
      this.backgroundColor,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            // fixedSize: Size(width!, height!),
            minimumSize: Size(width!, height!),
            backgroundColor: backgroundColor,
            foregroundColor: Colors.white),
        onPressed: onPressed,
        child: content);
  }
}
