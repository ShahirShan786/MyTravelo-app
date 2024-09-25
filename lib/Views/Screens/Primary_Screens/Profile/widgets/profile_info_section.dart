import 'package:flutter/material.dart';
import 'package:my_travelo_app/Models/singInModel.dart';
import 'package:my_travelo_app/constants/constant.dart';

class ProfileInfoSection extends StatelessWidget {
  const ProfileInfoSection({
    super.key,
    required this.profileDetail,
  });

  final Singinmodel? profileDetail;

  @override
  Widget build(BuildContext context) {
    // Get screen width and height using MediaQuery
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.only(
        top: screenHeight * 0.003, // 1% of the screen height for top padding
        left: screenWidth * 0.005, // 3% of the screen width for left padding
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            content:
                profileDetail != null ? profileDetail!.username ?? " " : "User",
            fontSize:
                screenWidth * 0.01, // 5% of the screen width for font size
            fontWeight: FontWeight.w700,
          ),
          SizedBox(
            height: screenHeight * 0.01, // 1% of screen height
          ),
          TextWidget(
            content: profileDetail != null
                ? profileDetail!.email ?? "email"
                : "email",
            fontSize:
                screenWidth * 0.01, // 4% of the screen width for font size
            fontWeight: FontWeight.w500,
          ),
          SizedBox(
            height: screenHeight * 0.001, // 0.5% of screen height
          ),
          TextWidget(
            content: profileDetail != null
                ? profileDetail!.phone ?? "phone"
                : 'phone',
            fontSize: screenWidth * 0.01, // 3.5% of screen width for font size
            fontWeight: FontWeight.w400,
          ),
        ],
      ),
    );
  }
}
