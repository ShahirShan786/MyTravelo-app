import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_travelo_app/Functions/user_functions.dart';
import 'package:my_travelo_app/constants/constable.dart';
import 'package:my_travelo_app/constants/constant.dart';
import 'package:my_travelo_app/constants/primary_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_travelo_app/models/user_model.dart';

class AddExpenseScreen extends StatefulWidget {
  final String tripId;
  ExpenseModel? editExpense;
  AddExpenseScreen({super.key, required this.tripId, this.editExpense});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  String selectedText = "General";
  String selectedImage = general;
  Color selectedColor = primaryLight;
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _discriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.editExpense != null) {
      selectedText = widget.editExpense!.category;
      selectedImage = widget.editExpense!.image;
      selectedColor = widget.editExpense!.color;
      _amountController.text = widget.editExpense!.amount;
      _discriptionController.text = widget.editExpense!.discription ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(
            content: "Add Expenses", fontSize: 20, fontWeight: FontWeight.bold),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: SizedBox(
              width: double.infinity,
              height: 90,
              child: Row(
                children: [
                  InkWell(
                      onTap: () {
                        catogoryDialogue(context: context);
                      },
                      child: Stack(
                        children: [
                          catogoryBox(
                              text: selectedText,
                              image: selectedImage,
                              color: selectedColor),
                          const Positioned(
                            right: -3,
                            top: -3,
                            child: CircleAvatar(
                              backgroundColor: ScaffoldColor,
                              radius: 12,
                              child: Center(
                                child: Icon(
                                  Icons.edit,
                                  color: black,
                                  size: 13,
                                ),
                              ),
                            ),
                          )
                        ],
                      )),
                  SizedBox(
                    width: 250,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(
                          height: 2,
                        ),
                        TextWidget(
                            content: "    Amount",
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[700]),
                        TextField(
                          controller: _amountController,
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[700]),
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "0.00",
                            prefixIcon: Icon(Icons.currency_rupee),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: _discriptionController,
              maxLines: 3,
              decoration: InputDecoration(
                  hintText: "Description (optional)",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: primaryColor))),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          PrimaryButton(
              content: TextWidget(
                content: "Add",
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: white,
              ),
              backgroundColor: primaryColor,
              width: 300,
              height: 50,
              onPressed: () async {
                if (_amountController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: red,
                      content: TextWidget(
                        content: "Enter amount",
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: white,
                      )));
                } else {
                  final expenseData = ExpenseModel(
                      id: widget.editExpense == null
                          ? DateTime.now().millisecondsSinceEpoch.toString()
                          : widget.editExpense!.id,
                      tripId: widget.editExpense == null
                          ? widget.tripId
                          : widget.editExpense!.tripId,
                      amount: _amountController.text,
                      discription: _discriptionController.text,
                      category: selectedText,
                      image: selectedImage,
                      color: selectedColor);
                  await addExpense(expenses: expenseData);
                  await expenseToList(tripId: widget.tripId);
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pop();
                }
              })
        ],
      ),
    );
  }

  catogoryDialogue({required context}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: TextWidget(
                content: "Select a Catogory",
                fontSize: 22,
                fontWeight: FontWeight.bold),
            content: SizedBox(
              width: 350.w,
              height: 200.h,
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childAspectRatio: 0.9),
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        selectedText = "General";
                        selectedImage = general;
                        selectedColor = primaryLight;
                      });
                      Navigator.of(context).pop();
                    },
                    child: catogoryBox(
                      text: "General",
                      image: general,
                      color: primaryLight,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        selectedText = "Meal";
                        selectedImage = meal;
                        selectedColor = mealColor;
                      });
                      Navigator.of(context).pop();
                    },
                    child: catogoryBox(
                      text: "Meal",
                      image: meal,
                      color: mealColor,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        selectedText = "Groceries";
                        selectedImage = groceries;
                        selectedColor = groceriesColor;
                      });
                      Navigator.of(context).pop();
                    },
                    child: catogoryBox(
                        text: "Groceries",
                        image: groceries,
                        color: groceriesColor),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        selectedText = "Drinks";
                        selectedImage = drink;
                        selectedColor = drinksColor;
                      });
                      Navigator.of(context).pop();
                    },
                    child: catogoryBox(
                      text: "Drinks",
                      image: drink,
                      color: drinksColor,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        selectedText = "Snacks";
                        selectedImage = snacks;
                        selectedColor = snacksColor;
                      });
                      Navigator.of(context).pop();
                    },
                    child: catogoryBox(
                      text: "Snacks",
                      image: snacks,
                      color: snacksColor,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        selectedText = "Hotel";
                        selectedImage = hotel;
                        selectedColor = hotelColor;
                      });
                      Navigator.of(context).pop();
                    },
                    child: catogoryBox(
                      text: "Hotel",
                      image: hotel,
                      color: hotelColor,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        selectedText = "Taxi";
                        selectedImage = taxi;
                        selectedColor = taxiColor;
                      });
                      Navigator.of(context).pop();
                    },
                    child: catogoryBox(
                      text: "Taxi",
                      image: taxi,
                      color: taxiColor,
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Close"))
            ],
          );
        });
  }

  Widget catogoryBox({
    required String text,
    required String image,
    required Color color,
  }) {
    return Container(
      width: 80,
      height: 80,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 53,
            height: 42,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SvgPicture.asset(
                image,
                height: 48,
                fit: BoxFit.fill,
              ),
            ),
          ),
          TextWidget(content: text, fontSize: 15, fontWeight: FontWeight.bold)
        ],
      ),
    );
  }
}
