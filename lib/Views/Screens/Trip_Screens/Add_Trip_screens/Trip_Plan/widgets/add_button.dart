import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_travelo_app/constants/constable.dart';
import 'package:my_travelo_app/constants/constant.dart';

class AddButton extends StatelessWidget {
  const AddButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: screenHeight * 0.05,
      width: screenWidth * 0.1,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          color: primaryColor, borderRadius: BorderRadius.circular(10.r)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextWidget(
            content: "Add",
            fontSize: screenWidth * 0.01,
            fontWeight: FontWeight.w600,
            color: white,
          ),
          Icon(
            Icons.arrow_forward_ios_outlined,
            size: screenWidth * 0.01,
            color: white,
          )
        ],
      ),
    );
  }
}
