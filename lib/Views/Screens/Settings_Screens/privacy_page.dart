import 'package:flutter/material.dart';
import 'package:my_travelo_app/constants/constant.dart';

class Privacypage extends StatelessWidget {
  const Privacypage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the screen size
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: TextWidget(
          content: "Privacy Policy",
          fontSize: screenSize.width * 0.05, // Adjusted for screen width
          fontWeight: FontWeight.bold,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  height:
                      screenSize.height * 0.01), // Adjusted for screen height
              _buildBigHeading(
                  content: "Privacy Policy", screenSize: screenSize),
              _buildParagraph(
                content: "Last updated: August 27, 2024",
                screenSize: screenSize,
              ),
              _buildParagraph(
                content:
                    "This Privacy Policy describes Our policies and procedures on the collection, use and disclosure of Your information when You use the Service and tells You about Your privacy rights and how the law protects You.",
                screenSize: screenSize,
              ),
              _buildParagraph(
                content:
                    "This Privacy Policy describes Our policies and procedures on the collection, use and disclosure of Your information when You use the Service and tells You about Your privacy rights and how the law protects You.",
                screenSize: screenSize,
              ),
              _buildBigHeading(
                  content: "Interpretation and Definitions",
                  screenSize: screenSize),
              _buildSubHEading(
                  content: "Interpretation", screenSize: screenSize),
              _buildParagraph(
                content:
                    "The words of which the initial letter is capitalized have meanings defined under the following conditions. The following definitions shall have the same meaning regardless of whether they appear in singular or in plural.",
                screenSize: screenSize,
              ),
              _buildSubHEading(content: "Definitions", screenSize: screenSize),
              _buildParagraph(
                  content: "For the purposes of this Privacy Policy:",
                  screenSize: screenSize),
              _buildList([
                "Account means a unique account created for You to access our Service or parts of our Service.",
                "Affiliate means an entity that controls, is controlled by or is under common control with a party, where 'control means ownership of 50% or more of the shares, equity interest or other securities entitled to vote for election of directors or other managing authority.",
                "Application refers to MyTravelo, the software program provided by the Company.",
                "Device means any device that can access the Service such as a computer, a cellphone or a digital tablet.",
                "Personal Data is any information that relates to an identified or identifiable individual.",
                "Service refers to the Application.",
                "Service Provider means any natural or legal person who processes the data on behalf of the Company.",
                "You means the individual accessing or using the Service, or the company, or other legal entity on behalf of which such individual is accessing or using the Service, as applicable.",
              ], screenSize),
              _buildBigHeading(
                  content: "Collecting and Using Your Personal Data",
                  screenSize: screenSize),
              _buildSubHEading(
                  content: "Types of Data Collected", screenSize: screenSize),
              _buildSubHEading(
                  content: "Personal Data", screenSize: screenSize),
              _buildParagraph(
                content:
                    "While using Our Service, We may ask You to provide Us with certain personally identifiable information that can be used to contact or identify You.",
                screenSize: screenSize,
              ),
              _buildList([
                "Email address",
                "First name and last name",
                "Phone number",
                "Address, State, Province, ZIP/Postal code, City",
                "Usage Data",
              ], screenSize),
              _buildSubHEading(content: "Usage Data", screenSize: screenSize),
              _buildParagraph(
                content:
                    "Usage Data is collected automatically when using the Service.",
                screenSize: screenSize,
              ),
              // ... Continue the same for the rest of the content
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBigHeading({required String content, required Size screenSize}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenSize.height * 0.02),
      child: TextWidget(
        content: content,
        fontSize: screenSize.width * 0.030,
        fontWeight: FontWeight.w900,
      ),
    );
  }

  Widget _buildSubHEading({required String content, required Size screenSize}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenSize.height * 0.01),
      child: TextWidget(
        content: content,
        fontSize: screenSize.width * 0.026,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildParagraph({required String content, required Size screenSize}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenSize.height * 0.01),
      child: TextWidget(
        content: content,
        fontSize: screenSize.width * 0.018,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildList(List<String> items, Size screenSize) {
    return Column(
      children: items
          .map((item) => Padding(
                padding: EdgeInsets.all(screenSize.width * 0.02),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: screenSize.height * 0.007,
                          right: screenSize.width * 0.02),
                      child: Icon(
                        Icons.circle,
                        size: screenSize.width * 0.01,
                      ),
                    ),
                    Expanded(
                      child: TextWidget(
                        content: item,
                        fontSize: screenSize.width * 0.020,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ))
          .toList(),
    );
  }
}
