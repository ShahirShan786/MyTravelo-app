import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_travelo_app/constants/constable.dart';

class PrimaryAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? titles;
  final Color? titileColors;
  final bool? centerTitles;
  final List<Widget>? actions;
  final Color? backgroundColors;
  final double? elevations;
  final Widget? leadings;
  final double? leadingsWidth;
  const PrimaryAppBar(
      {super.key,
      this.titles,
      this.titileColors,
      this.centerTitles,
      this.backgroundColors,
      this.actions,
      this.elevations,
       this.leadings, this.leadingsWidth});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      
      backgroundColor: backgroundColors ?? primaryColor,
      leading: leadings,
      elevation: elevations,
      leadingWidth: leadingsWidth,
      centerTitle: centerTitles ?? true,
      title: Text(titles ?? ""),
      titleTextStyle: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
        color: titileColors ?? black,
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize =>  Size.fromHeight(55.h);
}
