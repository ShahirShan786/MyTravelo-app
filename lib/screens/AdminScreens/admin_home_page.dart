import 'package:flutter/material.dart';
import 'package:my_travelo_app/constants/constant.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: TextWidget(
            content: "Admin Pannel", fontSize: 20, fontWeight: FontWeight.bold),
      ),
      body: Center(
        child: Text("ahsgdfhgad"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          
        },
      ),
    );
  }
}
