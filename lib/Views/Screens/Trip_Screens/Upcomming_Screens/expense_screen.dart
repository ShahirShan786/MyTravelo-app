import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:my_travelo_app/Controller/Hive/user_functions.dart';
import 'package:my_travelo_app/Views/Screens/Widgets/show_dialogues.dart';
import 'package:my_travelo_app/constants/constable.dart';
import 'package:my_travelo_app/constants/constant.dart';
import 'package:my_travelo_app/Models/user_model.dart';
import 'package:my_travelo_app/Views/Screens/Trip_Screens/Upcomming_Screens/add_expense_screen.dart';

class ExpenseScreen extends StatefulWidget {
  final String tripId;
  final DateTime tripStartDate;
  final DateTime tripEndDate;

  const ExpenseScreen(
      {super.key,
      required this.tripId,
      required this.tripStartDate,
      required this.tripEndDate});

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.tripStartDate; //setting here a default date;
    expenseToList(tripId: widget.tripId);
  }

  @override
  Widget build(BuildContext context) {
    log("Expense Length :${expenseListener.value.length}");

    double heightFactor = MediaQuery.of(context).size.height /
        812; // Assuming 812 is the height of the design
    double widthFactor = MediaQuery.of(context).size.width /
        375; // Assuming 375 is the width of the design

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 220 * heightFactor,
            child: Stack(
              children: [
                Container(
                  height: 180 * heightFactor,
                  width: MediaQuery.of(context).size.width,
                  color: ScaffoldColor,
                  padding: EdgeInsets.only(
                      left: 30 * widthFactor, top: 25 * heightFactor),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        content: "Welcome again",
                        fontSize: 8 * widthFactor,
                        fontWeight: FontWeight.bold,
                      ),
                      TextWidget(
                          content: "Add your expenses here",
                          fontSize: 8 * widthFactor,
                          fontWeight: FontWeight.bold)
                    ],
                  ),
                ),
                Positioned(
                  bottom: 9 * heightFactor,
                  left: 0,
                  child: Container(
                    width: 160 * widthFactor,
                    height: 80 * heightFactor,
                    margin: EdgeInsets.only(left: 10 * widthFactor),
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(50)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextWidget(
                          content: "Total Trip\n   Spend",
                          fontSize: 7 * widthFactor,
                          fontWeight: FontWeight.bold,
                          color: white,
                        ),
                        SizedBox(
                          width: 15 * widthFactor,
                        ),
                        ValueListenableBuilder(
                          valueListenable: expenseListener,
                          builder: (context, value, child) {
                            int totalExpense =
                                value.fold(0, (previousValue, element) {
                              int? expenses = int.tryParse(element.amount) ?? 0;
                              return previousValue + expenses;
                            });
                            return TextWidget(
                              content: "₹$totalExpense",
                              fontSize: 10 * widthFactor,
                              fontWeight: FontWeight.bold,
                              color: white,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5 * heightFactor),
            child: SizedBox(
              height: 60 * heightFactor,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.tripEndDate
                          .difference(widget.tripStartDate)
                          .inDays +
                      1,
                  itemBuilder: (context, index) {
                    DateTime date =
                        widget.tripStartDate.add(Duration(days: index));
                    bool isSelected = selectedDate == date;
                    return InkWell(
                        onTap: () {
                          setState(() {
                            selectedDate = date;
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.all(2 * widthFactor),
                          child: AnimatedContainer(
                            duration: const Duration(
                              milliseconds: 400,
                            ),
                            curve: Curves.easeOut,
                            width: isSelected
                                ? 60 * widthFactor
                                : 50 * widthFactor,
                            height: 100 * heightFactor,
                            decoration: BoxDecoration(
                                color: isSelected ? primaryColor : primaryLight,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: TextWidget(
                                content: DateFormat("dd MMM").format(date),
                                fontSize: isSelected
                                    ? 8 * widthFactor
                                    : 5 * widthFactor,
                                fontWeight: FontWeight.bold,
                                color: isSelected ? white : black,
                              ),
                            ),
                          ),
                        ));
                  }),
            ),
          ),
          Expanded(
              child: ValueListenableBuilder(
            valueListenable: expenseListener,
            builder: (context, value, child) {
              List<ExpenseModel> filteredExpenses = value
                  .where((expense) => isSameDay(expense.date, selectedDate))
                  .toList();
              return filteredExpenses.isNotEmpty
                  ? ListView.builder(
                      itemCount: filteredExpenses.length,
                      itemBuilder: (context, index) {
                        ExpenseModel data = filteredExpenses[index];

                        return buildExpenseContainer(data, context);
                      },
                    )
                  : Center(
                      child: Lottie.network(
                          "https://lottie.host/11affa91-4de3-4aca-8340-6fa60f2b1a6c/dt6OPkTq9j.json",
                          width: 200 * widthFactor,
                          height: 200 * heightFactor),
                    );
            },
          ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () {
          Get.to(
            () => AddExpenseScreen(
              tripId: widget.tripId,
              tripStartDate: widget.tripStartDate,
              tripEndDate: widget.tripEndDate,
            ),
          );
        },
        child: const Icon(
          Icons.add,
          color: white,
        ),
      ),
    );
  }

  Padding buildExpenseContainer(ExpenseModel data, BuildContext context) {
    double heightFactor = MediaQuery.of(context).size.height / 812;
    double widthFactor = MediaQuery.of(context).size.width / 375;

    return Padding(
      padding: EdgeInsets.all(10 * widthFactor),
      child: RepaintBoundary(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12 * widthFactor),
              height: 120 * heightFactor,
              child: Center(
                child: Container(
                  height: 130 * heightFactor,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15 * widthFactor),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black45,
                        spreadRadius: -8,
                        blurRadius: 32,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(5.0 * widthFactor),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RepaintBoundary(
                          child: Container(
                            width: 75 * widthFactor,
                            height: 60 * heightFactor,
                            margin: EdgeInsets.only(left: 10 * widthFactor),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(10 * widthFactor),
                              child: SvgPicture.asset(
                                data.image,
                                height: 5 * heightFactor,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextWidget(
                                content: "₹ ${data.amount}",
                                fontSize: 7 * widthFactor,
                                fontWeight: FontWeight.bold),
                            Container(
                              margin: EdgeInsets.only(top: 5 * heightFactor),
                              width: 15 * widthFactor,
                              child: Center(
                                child: Text(
                                  data.discription ?? '',
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          width: 100 * widthFactor,
                          height: 50 * heightFactor,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.to(
                                      () => AddExpenseScreen(
                                        tripId: widget.tripId,
                                        editExpense: data,
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: 42 * widthFactor,
                                    height: 42 * heightFactor,
                                    decoration: const BoxDecoration(
                                        color: Color.fromRGBO(214, 214, 214, 1),
                                        shape: BoxShape.circle),
                                    child: const Center(
                                      child: Icon(Icons.edit_note),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    showDeleteDialogue(
                                        context: context,
                                        content:
                                            "Are you sure you want to delete this ?",
                                        onpressed: () {
                                          Navigator.of(context).pop();
                                        });
                                  },
                                  child: Container(
                                    width: 42 * widthFactor,
                                    height: 42 * heightFactor,
                                    decoration: BoxDecoration(
                                        color: Colors.grey[350],
                                        shape: BoxShape.circle),
                                    child: const Center(
                                      child: Icon(
                                        Icons.delete_outlined,
                                        color: red,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 1 * heightFactor,
              left: 30 * widthFactor,
              child: Container(
                width: 50 * widthFactor,
                height: 25 * heightFactor,
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(20 * widthFactor)),
                child: Center(
                  child: Text(
                    data.category,
                    style: TextStyle(
                        fontSize: 4 * widthFactor,
                        fontWeight: FontWeight.bold,
                        color: white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool isSameDay(DateTime? firstDay, DateTime? lastDay) {
    if (firstDay == null || lastDay == null) return false;
    return firstDay.year == lastDay.year &&
        firstDay.month == lastDay.month &&
        firstDay.day == lastDay.day;
  }
}
