import 'package:flutter/material.dart';
import 'package:my_travelo_app/constants/constant.dart';

class Termspage extends StatelessWidget {
  const Termspage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the screen's width and height using MediaQuery
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: TextWidget(
          content: "Terms and Conditions",
          fontSize:
              screenWidth * 0.02, // Adjust font size based on screen width
          fontWeight: FontWeight.bold,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(
              screenWidth * 0.03), // Adjust padding based on screen width
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: screenHeight *
                    0.02, // Adjust spacing based on screen height
              ),
              _buildSubHeading(
                  content: "1. Introduction", screenWidth: screenWidth),
              _buildParagraph(
                  content:
                      "Welcome to MyTravelo. These Terms and Conditions govern your use of the MyTravelo app, including any data, content, or services provided through the app. By accessing or using MyTravelo, you agree to comply with these Terms and Conditions. If you do not agree with any part of these terms, please do not use the app.",
                  screenWidth: screenWidth),
              _buildSubHeading(
                  content: "2. Data Collection and Use",
                  screenWidth: screenWidth),
              _buildParagraph(
                  content:
                      "MyTravelo collects and uses data to provide and improve the app’s services. This data may include personal information, such as your name, email address, travel preferences, and location data. By using MyTravelo, you consent to the collection, use, and storage of this data in accordance with our Privacy Policy.",
                  screenWidth: screenWidth),
              _buildSubHeading(
                  content: "3. User Responsibilities",
                  screenWidth: screenWidth),
              _buildParagraph(
                  content:
                      "You are responsible for ensuring the accuracy and completeness of the data you provide to MyTravelo. You agree not to use the app for any unlawful or prohibited activities, including but not limited to:",
                  screenWidth: screenWidth),
              _buildList([
                "Misrepresenting your identity or providing false information.",
                "Using the app to transmit harmful, threatening, or obscene content.",
                "Attempting to gain unauthorized access to MyTravelo’s systems or data."
              ], screenWidth),
              _buildSubHeading(
                  content: "4. Data Accuracy", screenWidth: screenWidth),
              _buildParagraph(
                  content:
                      "While MyTravelo strives to provide accurate and up-to-date information, we do not guarantee the accuracy, completeness, or reliability of any data or content provided through the app. MyTravelo is not responsible for any errors or omissions in the data, nor for any actions taken based on the information provided.",
                  screenWidth: screenWidth),
              _buildSubHeading(
                  content: "5. Data Security", screenWidth: screenWidth),
              _buildParagraph(
                  content:
                      "MyTravelo takes reasonable measures to protect your data from unauthorized access, use, or disclosure. However, no system can be completely secure. By using the app, you acknowledge and accept the inherent risks associated with transmitting data over the internet.",
                  screenWidth: screenWidth),
              // Add the remaining sections similarly
              _buildSubHeading(
                  content: "6. Third-Party Services", screenWidth: screenWidth),
              _buildParagraph(
                  content:
                      "MyTravelo may include links to or integrate with third-party services, websites, or applications. These third-party services are not controlled by MyTravelo, and we are not responsible for their content, privacy practices, or terms of use. Your use of third-party services is at your own risk and subject to the terms and conditions of those services.",
                  screenWidth: screenWidth),
              // Remaining content
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubHeading(
      {required String content, required double screenWidth}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenWidth * 0.01),
      child: TextWidget(
        content: content,
        fontSize: screenWidth * 0.026,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildParagraph(
      {required String content, required double screenWidth}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenWidth * 0.02),
      child: TextWidget(
        content: content,
        fontSize: screenWidth * 0.018,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildList(List<String> items, double screenWidth) {
    return Column(
      children: items
          .map((item) => Padding(
                padding: EdgeInsets.all(screenWidth * 0.02),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: screenWidth * 0.01, right: screenWidth * 0.02),
                      child: Icon(
                        Icons.circle,
                        size: screenWidth * 0.02,
                      ),
                    ),
                    Expanded(
                      child: TextWidget(
                        content: item,
                        fontSize: screenWidth * 0.020,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ))
          .toList(),
    );
  }
}
