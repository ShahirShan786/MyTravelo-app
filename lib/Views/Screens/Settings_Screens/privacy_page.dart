import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_travelo_app/constants/constant.dart';

class Privacypage extends StatelessWidget {
  const Privacypage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: TextWidget(
              content: "Privacy Policy",
              fontSize: 20.sp,
              fontWeight: FontWeight.bold),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                  SizedBox(
                  height: 10.h,
                ),
                _buildBigHeading(content: "Privacy Policy"),
                _buildParagraph(content: "Last updated: August 27, 2024"),
                _buildParagraph(
                    content:
                        "This Privacy Policy describes Our policies and procedures on the collection, use and disclosure of Your information when You use the Service and tells You about Your privacy rights and how the law protects You."),
                _buildParagraph(
                    content:
                        "This Privacy Policy describes Our policies and procedures on the collection, use and disclosure of Your information when You use the Service and tells You about Your privacy rights and how the law protects You."),
                _buildBigHeading(content: "Interpretation and Definitions"),
                _buildSubHEading(content: "Interpretation"),
                _buildParagraph(
                    content:
                        "The words of which the initial letter is capitalized have meanings defined under the following conditions. The follsuowing definitions shall have the same meaning regardless of whether they appear in singular or in plural."),
                _buildSubHEading(content: "Definitions"),
                _buildParagraph(
                    content: "For the purposes of this Privacy Policy:"),
                _buildList([
                  "Account means a unique account created for You to access our Service or parts of our Service.",
                  "Affiliate means an entity that controls, is controlled by or is under common control with a party, where 'control means ownership of 50% or more of the shares, equity interest or other securities entitled to vote for election of directors or other managing authority",
                  "Application refers to MyTravelo, the software program provided by the Company.",
                  "Device means any device that can access the Service such as a computer, a cellphone or a digital tablet.",
                  "Personal Data is any information that relates to an identified or identifiable individual.",
                  "Service refers to the Application.",
                  "Service Provider means any natural or legal person who processes the data on behalf of the Company. It refers to third-party companies or individuals employed by the Company to facilitate the Service, to provide the Service on behalf of the Company, to perform services related to the Service or to assist the Company in analyzing how the Service is used.",
                  "You means the individual accessing or using the Service, or the company, or other legal entity on behalf of which such individual is accessing or using the Service, as applicable.",
                ]),
                _buildBigHeading(
                    content: "Collecting and Using Your Personal Data"),
                _buildSubHEading(content: "Types of Data Collected"),
                _buildSubHEading(content: "Personal Data"),
                _buildParagraph(
                    content:
                        "While using Our Service, We may ask You to provide Us with certain personally identifiable information that can be used to contact or identify You. Personally identifiable information may include, but is not limited to:"),
                _buildList([
                  "Email address",
                  "First name and last name",
                  "Phone number",
                  "Address, State, Province, ZIP/Postal code, City",
                  "Usage Data"
                ]),
                _buildSubHEading(content: "Usage Data"),
                _buildParagraph(
                    content:
                        "Usage Data is collected automatically when using the Service."),
                _buildParagraph(
                    content:
                        "Usage Data may include information such as Your Device's Internet Protocol address (e.g. IP address), browser type, browser version, the pages of our Service that You visit, the time and date of Your visit, the time spent on those pages, unique device identifiers and other diagnostic data."),
                _buildParagraph(
                    content:
                        "When You access the Service by or through a mobile device, We may collect certain information automatically, including, but not limited to, the type of mobile device You use, Your mobile device unique ID, the IP address of Your mobile device, Your mobile operating system, the type of mobile Internet browser You use, unique device identifiers and other diagnostic data."),
                _buildParagraph(
                    content:
                        "We may also collect information that Your browser sends whenever You visit our Service or when You access the Service by or through a mobile device."),
                _buildSubHEading(
                    content:
                        "Information Collected while Using the Application"),
                _buildParagraph(
                    content:
                        "While using Our Application, in order to provide features of Our Application, We may collect, with Your prior permission:"),
                _buildList([
                  "Information from your Device's phone book (contacts list)",
                  "Pictures and other information from your Device's camera and photo library",
                ]),
                _buildParagraph(
                    content:
                        "We use this information to provide features of Our Service, to improve and customize Our Service. The information may be uploaded to the Company's servers and/or a Service Provider's server or it may be simply stored on Your device."),
                _buildParagraph(
                    content:
                        "You can enable or disable access to this information at any time, through Your Device settings."),
                _buildSubHEading(content: "Use of Your Personal Data"),
                _buildParagraph(
                    content:
                        "The Company may use Personal Data for the following purposes:"),
                _buildList([
                  "To provide and maintain our Service, including to monitor the usage of our Service.",
                  "To manage Your Account: to manage Your registration as a user of the Service. The Personal Data You provide can give You access to different functionalities of the Service that are available to You as a registered user.",
                  "For the performance of a contract: the development, compliance and undertaking of the purchase contract for the products, items or services You have purchased or of any other contract with Us through the Service",
                  "To contact You: To contact You by email, telephone calls, SMS, or other equivalent forms of electronic communication, such as a mobile application's push notifications regarding updates or informative communications related to the functionalities, products or contracted services, including the security updates, when necessary or reasonable for their implementation."
                      "To provide You with news, special offers and general information about other goods, services and events which we offer that are similar to those that you have already purchased or enquired about unless You have opted not to receive such information.",
                  "To manage Your requests: To attend and manage Your requests to Us.",
                  "For other purposes: We may use Your information for other purposes, such as data analysis, identifying usage trends, determining the effectiveness of our promotional campaigns and to evaluate and improve our Service, products, services, marketing and your experience.",
                ]),
                _buildParagraph(
                    content:
                        "For other purposes: We may use Your information for other purposes, such as data analysis, identifying usage trends, determining the effectiveness of our promotional campaigns and to evaluate and improve our Service, products, services, marketing and your experience."),
                _buildList([
                  "With Service Providers: We may share Your personal information with Service Providers to monitor and analyze the use of our Service, to contact You.",
                  "For business transfers: We may share or transfer Your personal information in connection with, or during negotiations of, any merger, sale of Company assets, financing, or acquisition of all or a portion of Our business to another company.",
                  "With Affiliates: We may share Your information with Our affiliates, in which case we will require those affiliates to honor this Privacy Policy. Affiliates include Our parent company and any other subsidiaries, joint venture partners or other companies that We control or that are under common control with Us.",
                  "With Your consent: We may disclose Your personal information for any other purpose with Your consent."
                ]),
                _buildBigHeading(content: "Delete Your Personal Data"),
                _buildParagraph(
                    content:
                        "You have the right to delete or request that We assist in deleting the Personal Data that We have collected about You."),
                _buildParagraph(
                    content:
                        "Our Service may give You the ability to delete certain information about You from within the Service."),
                _buildParagraph(
                    content:
                        "You may update, amend, or delete Your information at any time by signing in to Your Account, if you have one, and visiting the account settings section that allows you to manage Your personal information. You may also contact Us to request access to, correct, or delete any personal information that You have provided to Us."),
                _buildParagraph(
                    content:
                        "Please note, however, that We may need to retain certain information when we have a legal obligation or lawful basis to do so."),
                _buildBigHeading(content: "Children's Privacy"),
                _buildParagraph(
                    content:
                        "Our Service does not address anyone under the age of 13. We do not knowingly collect personally identifiable information from anyone under the age of 13. If You are a parent or guardian and You are aware that Your child has provided Us with Personal Data, please contact Us. If We become aware that We have collected Personal Data from anyone under the age of 13 without verification of parental consent, We take steps to remove that information from Our servers."),
                _buildParagraph(
                    content:
                        "If We need to rely on consent as a legal basis for processing Your information and Your country requires consent from a parent, We may require Your parent's consent before We collect and use that information."),
                _buildBigHeading(content: "Contact Us"),
                _buildParagraph(
                    content:
                        "If you have any questions about this Privacy Policy, You can contact us:"),
                _buildList(["By email: shahirshan786@gmail.com"])
              ],
            ),
          ),
        ));
  }

  Widget _buildBigHeading({required String content}) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 10.h),
      child: TextWidget(
        content: content,
        fontSize: 25.sp,
        fontWeight: FontWeight.w900,
      ),
    );
  }

  Widget _buildSubHEading({required String content}) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 5.h),
      child: TextWidget(
          content: content, fontSize: 23, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildParagraph({required String content}) {
    return Padding(
      padding:  EdgeInsets.symmetric(
        vertical: 10.h,
      ),
      child: TextWidget(
          content: content, fontSize: 18, fontWeight: FontWeight.w500),
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
                        child: Icon(
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
