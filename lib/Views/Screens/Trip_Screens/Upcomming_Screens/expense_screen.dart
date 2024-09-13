import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:my_travelo_app/Controller/Hive/signIn_service.dart';
import 'package:my_travelo_app/Controller/Hive/user_functions.dart';
import 'package:my_travelo_app/Views/Screens/Widgets/show_dialogues.dart';
import 'package:my_travelo_app/Views/Screens/Widgets/trip_deatails_screen_widget.dart';
import 'package:my_travelo_app/constants/constable.dart';
import 'package:my_travelo_app/constants/constant.dart';
import 'package:my_travelo_app/Models/singInModel.dart';
import 'package:my_travelo_app/Models/user_model.dart';
import 'package:lottie/lottie.dart';
import 'package:my_travelo_app/Views/Screens/Trip_Screens/Upcomming_Screens/add_expense_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 220,
            child: Stack(
              children: [
                Container(
                  height: 180,
                  width: MediaQuery.of(context).size.width,
                  color: ScaffoldColor,
                  padding: const EdgeInsets.only(left: 30, top: 56),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        content: "Welcome again",
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      TextWidget(
                          content: "Add your expenses here",
                          fontSize: 26,
                          fontWeight: FontWeight.bold)
                    ],
                  ),
                ),
                Positioned(
                  bottom: 5,
                  left: 0,
                  child: Container(
                    width: 270,
                    height: 80,
                    margin: const EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(50)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextWidget(
                          content: "Total Trip\n   Spend",
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: white,
                        ),
                        const SizedBox(
                          width: 20,
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
                              fontSize: 25,
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
            padding: const EdgeInsets.only(top: 5),
            child: SizedBox(
              height: 60,
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
                          padding: const EdgeInsets.all(2),
                          child: AnimatedContainer(
                            duration: const Duration(
                              milliseconds: 400,
                            ),
                            curve: Curves.easeOut,
                            width: isSelected ? 100 : 80,
                            height: 50,
                            decoration: BoxDecoration(
                                color: isSelected ? primaryColor : primaryLight,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: TextWidget(
                                content: DateFormat("dd MMM").format(date),
                                fontSize: isSelected ? 16 : 13,
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
                          width: 200,
                          height: 200),
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
    return Padding(
      padding: const EdgeInsets.all(10),
      child: RepaintBoundary(
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              height: 120,
              child: Center(
                child: Container(
                  height: 90,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black45,
                        spreadRadius: -8,
                        blurRadius: 32,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RepaintBoundary(
                          child: Container(
                            width: 75,
                            height: 60,
                            margin: const EdgeInsets.only(left: 10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: SvgPicture.asset(
                                data.image,
                                height: 55,
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
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                            Container(
                              margin: const EdgeInsets.only(top: 5),
                              width: 120,
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
                          width: 100,
                          height: 50,
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
                                    width: 42,
                                    height: 42,
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
                                          deleteExpense(expense: data);
                                          expenseToList(tripId: data.tripId);
                                          log("delete pressed");
                                          Navigator.of(context).pop();
                                        });
                                  },
                                  child: Container(
                                    width: 42,
                                    height: 42,
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
              top: 2,
              left: 30,
              child: Container(
                width: 115,
                height: 25,
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(20)),
                child: Center(
                  child: Text(
                    data.category,
                    style: const TextStyle(
                        fontSize: 18,
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
