import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_travelo_app/Controller/Hive/user_functions.dart';
import 'package:my_travelo_app/constants/constable.dart';
import 'package:my_travelo_app/constants/constant.dart';
import 'package:my_travelo_app/constants/primary_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_travelo_app/Models/user_model.dart';

class AddExpenseScreen extends StatefulWidget {
  final String tripId;
  final DateTime? tripStartDate;
  final DateTime? tripEndDate;
  ExpenseModel? editExpense;

  AddExpenseScreen(
      {super.key,
      required this.tripId,
      this.editExpense,
      this.tripStartDate,
      this.tripEndDate});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  DateTime? selectedRange;
  String selectedText = "General";
  String selectedImage = general;
  Color selectedColor = primaryLight;
  late final DateTime? selectedDateRange;

  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _discriptionController = TextEditingController();
  final ValueNotifier<String?> selectRangeNotifier =
      ValueNotifier<String?>(null);

  @override
  void initState() {
    super.initState();
    if (widget.editExpense != null) {
      selectedText = widget.editExpense!.category;
      selectedImage = widget.editExpense!.image;
      selectedColor = widget.editExpense!.color;
      _amountController.text = widget.editExpense!.amount;
      _discriptionController.text = widget.editExpense!.discription ?? "";
      selectedDateRange = widget.editExpense!.date;
      selectRangeNotifier.value =
          DateFormat("dd MM yyyy").format(widget.editExpense!.date!);
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    _discriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Apply MediaQuery for responsiveness
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Scaffold(
      appBar: AppBar(
        title: TextWidget(
            content:
                widget.editExpense == null ? "Add Expenses" : "Edit Expenses",
            fontSize: 20,
            fontWeight: FontWeight.bold),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(width * 0.02),
            child: SizedBox(
              width: double.infinity,
              height: height * 0.12,
              child: Row(
                children: [
                  InkWell(
                      onTap: () => catogoryDialogue(context: context),
                      child: Stack(
                        children: [
                          catogoryBox(
                              text: selectedText,
                              image: selectedImage,
                              color: selectedColor),
                          Positioned(
                            right: -width * 0.01,
                            top: -height * 0.01,
                            child: CircleAvatar(
                              backgroundColor: ScaffoldColor,
                              radius: width * 0.005,
                              child: Center(
                                child: Icon(
                                  Icons.edit,
                                  color: black,
                                  size: width * 0.002,
                                ),
                              ),
                            ),
                          )
                        ],
                      )),
                  Stack(
                    children: [
                      SizedBox(
                        width: width * 0.65,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextWidget(
                                content: "    Amount",
                                fontSize: width * 0.02,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[700]),
                            TextField(
                              controller: _amountController,
                              style: TextStyle(
                                  fontSize: width * 0.016,
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
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: InkWell(
                          onTap: () {
                            selectDate(context, widget.tripStartDate!,
                                widget.tripEndDate!, (selectedDate) {
                              selectedDateRange = selectedDate;
                              final finalSelectDate =
                                  DateFormat("dd MM yyyy").format(selectedDate);
                              selectRangeNotifier.value = finalSelectDate;
                            });
                          },
                          child: CircleAvatar(
                            backgroundColor: red,
                            radius: width * 0.02,
                            child: const Icon(
                              Icons.calendar_today,
                              color: white,
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.10),
            child: TextField(
              controller: _discriptionController,
              maxLines: 3,
              decoration: InputDecoration(
                  hintText: "Description (optional)",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(width * 0.03),
                      borderSide: const BorderSide(color: primaryColor))),
            ),
          ),
          SizedBox(
            height: height * 0.01,
          ),
          ValueListenableBuilder(
              valueListenable: selectRangeNotifier,
              builder: (context, selectedRange, child) {
                return TextWidget(
                    content: selectedRange != null
                        ? selectedRange.toString()
                        : "Selected Date",
                    fontSize: width * 0.02,
                    fontWeight: FontWeight.bold);
              }),
          SizedBox(
            height: width * 0.02,
          ),
          primaryButton(context)
        ],
      ),
    );
  }

  PrimaryButton primaryButton(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;

    return PrimaryButton(
        content: TextWidget(
          content: widget.editExpense == null ? "Add" : "Update",
          fontSize: width * 0.010,
          fontWeight: FontWeight.bold,
          color: white,
        ),
        backgroundColor: primaryColor,
        width: width * 0.05,
        height: width * 0.04,
        onPressed: () async {
          if (_amountController.text.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: red,
                content: TextWidget(
                  content: "Enter amount",
                  fontSize: width * 0.04,
                  fontWeight: FontWeight.bold,
                  color: white,
                )));
          } else if (selectedDateRange == null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: red,
                content: TextWidget(
                  content: "please select the date",
                  fontSize: width * 0.04,
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
                color: selectedColor,
                date: selectedDateRange!);
            await addExpense(expenses: expenseData);
            await expenseToList(tripId: widget.tripId);
            Get.back();
          }
        });
  }

  catogoryDialogue({required context}) => Get.defaultDialog(
        title: "Select Category",
        titleStyle: TextStyle(
          fontSize: MediaQuery.of(context).size.width * 0.04,
          fontWeight: FontWeight.bold,
        ),
        titlePadding: EdgeInsets.only(
          right: MediaQuery.of(context).size.width * 0.3,
          top: MediaQuery.of(context).size.height * 0.02,
          bottom: MediaQuery.of(context).size.width * 0.05,
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05,
          vertical: MediaQuery.of(context).size.height * 0.01,
        ),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.25,
          child: GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 8,
              crossAxisSpacing: 2,
              childAspectRatio: 2,
            ),
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
                  color: groceriesColor,
                ),
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
          Align(
            alignment: Alignment.bottomRight,
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Close"),
            ),
          )
        ],
      );

  Widget catogoryBox({
    required String text,
    required String image,
    required Color color,
  }) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.06,
      height: MediaQuery.of(context).size.height * 0.10,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.13,
            height: MediaQuery.of(context).size.height * 0.06,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SvgPicture.asset(
                image,
                height: MediaQuery.of(context).size.height * 0.02,
                fit: BoxFit.fill,
              ),
            ),
          ),
          TextWidget(
            content: text,
            fontSize: MediaQuery.of(context).size.width * 0.01,
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
    );
  }

  Future<void> selectDate(BuildContext context, DateTime tripStartDate,
      DateTime tripEndDate, Function(DateTime) onDateSelected) async {
    final DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: tripStartDate,
        firstDate: tripStartDate,
        lastDate: tripEndDate,
        selectableDayPredicate: (DateTime date) {
          return date
                  .isAfter(tripStartDate.subtract(const Duration(days: 1))) &&
              date.isBefore(tripEndDate.add(const Duration(days: 1)));
        });
    if (selectedDate != null) {
      onDateSelected(selectedDate);
    }
  }
}
