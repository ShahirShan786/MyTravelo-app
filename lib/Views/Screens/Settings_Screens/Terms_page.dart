import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_travelo_app/constants/constant.dart';

class Termspage extends StatelessWidget {
  const Termspage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: TextWidget(
              content: "Terms and Conditions",
              fontSize: 20.sp,
              fontWeight: FontWeight.bold),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding:  EdgeInsets.all(10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10.h,
                ),
                _buildSubHEading(content: "1. Introduction"),
                _buildParagraph(
                    content:
                        "Welcome to MyTravelo. These Terms and Conditions govern your use of the MyTravelo app, including any data, content, or services provided through the app. By accessing or using MyTravelo, you agree to comply with these Terms and Conditions. If you do not agree with any part of these terms, please do not use the app."),
                _buildSubHEading(content: "2. Data Collection and Use"),
                _buildParagraph(
                    content:
                        "MyTravelo collects and uses data to provide and improve the app’s services. This data may include personal information, such as your name, email address, travel preferences, and location data. By using MyTravelo, you consent to the collection, use, and storage of this data in accordance with our Privacy Policy."),
                _buildSubHEading(content: "3. User Responsibilities"),
                _buildParagraph(
                    content:
                        "You are responsible for ensuring the accuracy and completeness of the data you provide to MyTravelo. You agree not to use the app for any unlawful or prohibited activities, including but not limited to:"),
                _buildList([
                  "Misrepresenting your identity or providing false information.",
                  "Using the app to transmit harmful, threatening, or obscene content.",
                  "Attempting to gain unauthorized access to MyTravelo’s systems or data."
                ]),
                _buildSubHEading(content: "4. Data Accuracy"),
                _buildParagraph(
                    content:
                        "While MyTravelo strives to provide accurate and up-to-date information, we do not guarantee the accuracy, completeness, or reliability of any data or content provided through the app. MyTravelo is not responsible for any errors or omissions in the data, nor for any actions taken based on the information provided."),
                _buildSubHEading(content: "5. Data Security"),
                _buildParagraph(
                    content:
                        "MyTravelo takes reasonable measures to protect your data from unauthorized access, use, or disclosure. However, no system can be completely secure. By using the app, you acknowledge and accept the inherent risks associated with transmitting data over the internet."),
                _buildSubHEading(content: "6. Third-Party Services"),
                _buildParagraph(
                    content:
                        "MyTravelo may include links to or integrate with third-party services, websites, or applications. These third-party services are not controlled by MyTravelo, and we are not responsible for their content, privacy practices, or terms of use. Your use of third-party services is at your own risk and subject to the terms and conditions of those services."),
                _buildSubHEading(content: "7. Intellectual Property"),
                _buildParagraph(
                    content:
                        "All content, features, and functionality provided through MyTravelo, including but not limited to text, graphics, logos, and software, are the property of MyTravelo or its licensors and are protected by intellectual property laws. You may not use, reproduce, modify, or distribute any content from the app without our prior written permission."),
                _buildSubHEading(content: "8. Limitation of Liability"),
                _buildParagraph(
                    content:
                        "To the fullest extent permitted by law, MyTravelo shall not be liable for any direct, indirect, incidental, consequential, or punitive damages arising out of or related to your use of the app or any data provided through the app. This includes, but is not limited to, damages for loss of profits, data, or other intangible losses."),
                _buildSubHEading(content: "9. Termination"),
                _buildParagraph(
                    content:
                        "MyTravelo reserves the right to terminate or suspend your access to the app at any time, without notice, for any reason, including but not limited to a violation of these Terms and Conditions. Upon termination, your right to use the app will immediately cease."),
                _buildSubHEading(
                    content: "10. Changes to Terms and Conditions"),
                _buildParagraph(
                    content:
                        "MyTravelo may update these Terms and Conditions from time to time. Any changes will be posted within the app, and your continued use of the app after such changes constitutes your acceptance of the updated terms."),
                _buildSubHEading(content: "11. Governing Law"),
                _buildParagraph(
                    content:
                        "These Terms and Conditions shall be governed by and construed in accordance with the laws of india, without regard to its conflict of law principles."),
                _buildSubHEading(content: "12. Contact Information"),
                _buildParagraph(
                    content:
                        "If you have any questions or concerns about these Terms and Conditions, please contact us at Shahirshan786@gmail.com.")
              ],
            ),
          ),
        ));
  }

 

  Widget _buildSubHEading({required String content}) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 5.h),
      child: TextWidget(
          content: content, fontSize: 23.sp, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildParagraph({required String content}) {
    return Padding(
      padding:  EdgeInsets.symmetric(
        vertical: 10.h,
      ),
      child: TextWidget(
          content: content, fontSize: 18.sp, fontWeight: FontWeight.w500),
    );
  }

  Widget _buildList(List<String> items) {
    return Column(
        children: items
            .map((item) => Padding(
                  padding:  EdgeInsets.all(8.0.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:  EdgeInsets.only(top: 6.h, right: 10.w),
                        child:  Icon(
                          Icons.circle,
                          size: 8.w,
                        ),
                      ),
                      Expanded(
                          child: TextWidget(
                              content: item,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500))
                    ],
                  ),
                ))
            .toList());
  }
}
