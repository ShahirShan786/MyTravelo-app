import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_travelo_app/constants/constable.dart';
import 'package:my_travelo_app/constants/constant.dart';

class DreamDestinationScreen extends StatelessWidget {
  

  const DreamDestinationScreen({super.key});
 
  @override
  Widget build(BuildContext context) {
     TextEditingController destinationController = TextEditingController();
     TextEditingController totalExpenseController = TextEditingController();
     TextEditingController totalSavingController = TextEditingController();
     final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        foregroundColor: white,
        title: TextWidget(
            content: "Dream Destination",
            fontSize: 20,
            fontWeight: FontWeight.bold),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: FloatingActionButton(
          backgroundColor: primaryColor,
          onPressed: () {
            Get.defaultDialog(
              title: "Add Dream Destination",
              titlePadding:const EdgeInsets.only(top: 20),
              titleStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              content: SizedBox(
                width: 300,
                child: Form(
                  child: Column(
                    children: [
                     const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: destinationController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              label: const Text("Destination Name"),
                              labelStyle: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[600])),
                                  validator: (value) {
                                    if(value == null || value.isEmpty){
                                      return "Enter the destination";
                                    }
                                    return null;
                                  },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: totalExpenseController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              label: const Text("Total Expenses"),
                              labelStyle: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[600])),
                                  validator: (value) {
                                    if(value == null || value.isEmpty){
                                      return "Enter total expense";
                                    }
                                    return null;
                                  },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: totalSavingController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              label:const Text("Total Savings"),
                              labelStyle: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[600])),
                                  validator: (value) {
                                    if(value == null || value.isEmpty){
                                      return "Enter total savings";
                                    }
                                    return null;
                                  },
                        ),
                      ),
                     const SizedBox(
                        height: 50,
                      )
                    ],
                  ),
                ),
              ),
              confirm: Padding(
                padding: const EdgeInsets.only(bottom: 20, left: 10),
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(primaryColor),
                        foregroundColor: WidgetStateProperty.all(white)),
                    onPressed: () {},
                    child: const Text("Add")),
              ),
              cancel: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(primaryColor),
                      foregroundColor: WidgetStateProperty.all(white)),
                  onPressed: () {
                    Get.back();
                  },
                  child:const Text("Cancel")),
            );
          },
          child: const Icon(
            Icons.add,
            color: white,
          ),
        ),
      ),
    );
  }
}
