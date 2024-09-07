import 'package:flutter/material.dart';
import 'package:my_travelo_app/constants/constable.dart';

class PrimaryAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? titles;
  final Color? titileColors;
  final bool? centerTitles;
  final List<Widget>? actions;
  final Color? backgroundColors;
  final double? elevations;
  const PrimaryAppBar(
      {super.key,
      this.titles,
      this.titileColors,
      this.centerTitles,
      this.backgroundColors,
      this.actions,
      this.elevations});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColors ?? primaryColor,
      elevation: elevations,
      centerTitle: centerTitles ?? true,
      title: Text(titles ?? ""),
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: titileColors ?? black,
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(55);
}
