import 'package:flutter/material.dart';
import 'package:my_travelo_app/constants/constant.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Screen dimensions using MediaQuery
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: TextWidget(
          content: "About us",
          fontSize: screenWidth * 0.05, // 5% of screen width for title
          fontWeight: FontWeight.bold,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.03), // 3% padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: screenHeight * 0.02, // 2% of screen height for spacing
              ),
              _buildBigHeading(
                content: "About us",
                context: context,
              ),
              _buildParagraph(
                content:
                    "Welcome to MyTravelo, your ultimate personal travel companion designed to turn your travel dreams into reality. In today’s fast-paced world, planning a trip can be overwhelming, with countless details to consider, destinations to explore, and itineraries to organize. MyTravelo is here to simplify that process, providing you with a seamless, all-in-one platform to discover new destinations, plan every aspect of your journey, and keep everything organized in one convenient place.",
                context: context,
              ),
              _buildParagraph(
                content:
                    "At its core, MyTravelo is a personalized travel app that puts you in control of your adventures. Whether you're a seasoned traveler looking to explore new horizons or someone planning their first big trip, MyTravelo is tailored to meet your unique needs. Our app is designed with a user-friendly interface that makes it easy to search for and discover breathtaking destinations worldwide. From iconic landmarks to hidden gems, MyTravelo offers a curated selection of places to visit, each with detailed information to help you make informed decisions.",
                context: context,
              ),
              _buildParagraph(
                content:
                    "But MyTravelo is more than just a destination guide. It’s a comprehensive travel planning tool that allows you to create and customize your itinerary according to your preferences. With MyTravelo, you can plan every aspect of your trip, from flights and accommodations to activities and dining experiences. Our app enables you to organize your itinerary day by day, ensuring that you make the most of your time at each destination. You can even set reminders for important activities and events, so you never miss out on anything during your trip.",
                context: context,
              ),
              _buildParagraph(
                content:
                    "One of the standout features of MyTravelo is its ability to personalize your travel experience. We understand that every traveler is unique, with different interests, preferences, and travel styles. That’s why MyTravelo allows you to tailor your itinerary based on what matters most to you. Whether you’re an adventure seeker, a history buff, or someone who loves to relax by the beach, MyTravelo helps you create a travel plan that reflects your passions and desires",
                context: context,
              ),
              _buildParagraph(
                content:
                    "In addition to helping you plan your trip, MyTravelo also serves as a valuable resource during your journey. With our app, you can easily access your itinerary on the go, make last-minute adjustments, and keep track of your travel documents and reservations. MyTravelo ensures that you’re always prepared, no matter where your travels take you. Plus, our app offers travel tips, recommendations, and insights to enhance your experience, making sure you get the most out of every destination you visit.",
                context: context,
              ),
              _buildParagraph(
                content:
                    "Whether you’re planning a weekend getaway or a month-long expedition, MyTravelo is your trusted companion every step of the way. We’re committed to helping you create unforgettable memories, one trip at a time. Download MyTravelo today and start exploring the world with confidence, knowing that your perfect itinerary is just a few taps away. With MyTravelo, the journey is just as exciting as the destination. Let’s make your travel dreams come true!",
                context: context,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Updated heading builder using MediaQuery
  Widget _buildBigHeading(
      {required String content, required BuildContext context}) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height *
              0.015), // 1.5% vertical spacing
      child: TextWidget(
        content: content,
        fontSize: screenWidth * 0.040, // 6.5% of screen width for heading
        fontWeight: FontWeight.w900,
      ),
    );
  }

  // Updated paragraph builder using MediaQuery
  Widget _buildParagraph(
      {required String content, required BuildContext context}) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: screenWidth * 0.02), // 2% vertical padding
      child: TextWidget(
        content: content,
        fontSize:
            screenWidth * 0.018, // 4.5% of screen width for paragraph text
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
