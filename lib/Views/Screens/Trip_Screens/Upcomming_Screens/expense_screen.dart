import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 220.h,
            child: Stack(
              children: [
                Container(
                  height: 180.h,
                  width: MediaQuery.of(context).size.width,
                  color: ScaffoldColor,
                  padding:  EdgeInsets.only(left: 30.r, top: 56.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        content: "Welcome again",
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      TextWidget(
                          content: "Add your expenses here",
                          fontSize: 26.sp,
                          fontWeight: FontWeight.bold)
                    ],
                  ),
                ),
                Positioned(
                  bottom: 5.h,
                  left: 0,
                  child: Container(
                    width: 270.w,
                    height: 80.h,
                    margin:  EdgeInsets.only(left: 10.w),
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(50)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextWidget(
                          content: "Total Trip\n   Spend",
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                          color: white,
                        ),
                         SizedBox(
                          width: 20.w,
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
                              fontSize: 25.sp,
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
            padding:  EdgeInsets.only(top: 5.h),
            child: SizedBox(
              height: 60.h,
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
                          padding:  EdgeInsets.all(2.w),
                          child: AnimatedContainer(
                            duration: const Duration(
                              milliseconds: 400,
                            ),
                            curve: Curves.easeOut,
                            width: isSelected ? 100 : 80,
                            height: 50.h,
                            decoration: BoxDecoration(
                                color: isSelected ? primaryColor : primaryLight,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: TextWidget(
                                content: DateFormat("dd MMM").format(date),
                                fontSize: isSelected ? 16.sp : 13.sp,
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
                          width: 200.w,
                          height: 200.h),
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
      padding:  EdgeInsets.all(10.w),
      child: RepaintBoundary(
        child: Stack(
          children: [
            Container(
              padding:  EdgeInsets.symmetric(horizontal: 12.w),
              height: 120.h,
              child: Center(
                child: Container(
                  height: 90.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.r),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black45,
                        spreadRadius: -8,
                        blurRadius: 32,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding:  EdgeInsets.all(5.0.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RepaintBoundary(
                          child: Container(
                            width: 75.w,
                            height: 60.h,
                            margin:  EdgeInsets.only(left: 10.w),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.r),
                              child: SvgPicture.asset(
                                data.image,
                                height: 55.h,
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
                                fontSize: 25.sp,
                                fontWeight: FontWeight.bold),
                            Container(
                              margin:  EdgeInsets.only(top: 5.h),
                              width: 120.w,
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
                          width: 100.w,
                          height: 50.h,
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
                                    width: 42.w,
                                    height: 42.h,
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
                                    width: 42.w,
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
              top: 2.h,
              left: 30.w,
              child: Container(
                width: 115.w,
                height: 25.h,
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(20.r)),
                child: Center(
                  child: Text(
                    data.category,
                    style:  TextStyle(
                        fontSize: 18.sp,
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
