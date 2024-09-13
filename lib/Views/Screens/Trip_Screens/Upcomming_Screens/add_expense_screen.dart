
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      selectRangeNotifier.value = DateFormat("dd MM yyyy").format(widget.editExpense!.date!);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _amountController.dispose();
    _discriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(
            content: widget.editExpense == null ? "Add Expenses" : "Edit Expenses", fontSize: 20, fontWeight: FontWeight.bold),
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
                      onTap: () =>  catogoryDialogue(context: context),
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
                  Stack(
                    children: [
                      SizedBox(
                        width: 250,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
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
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: InkWell(
                          onTap: () {
                            selectDate(context, widget.tripStartDate!,
                                widget.tripEndDate!, (selectedDate) {
                              selectedDateRange = selectedDate;
                              final finalSelectDate = DateFormat("dd MM yyyy").format(selectedDate);
                                  selectRangeNotifier.value = finalSelectDate;
                                });
                          },
                          child:const CircleAvatar(
                            backgroundColor: red,
                            radius: 22,
                            child:   Icon(
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
            height: 5,
          ),
          ValueListenableBuilder(
              valueListenable: selectRangeNotifier,
              builder: (context, selectedRange, child) {
                return TextWidget(
                    content: selectedRange != null
                        ? selectedRange.toString()
                        : "Selected Date",
                    fontSize: 20,
                    fontWeight: FontWeight.bold);
              }),
        const  SizedBox(
            height: 20,
          ),
          primaryButton(context)
        ],
      ),
    );
  }

  PrimaryButton primaryButton(BuildContext context) {
    return PrimaryButton(
            content: TextWidget(
              content: widget.editExpense == null ? "Add" : "Update",
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
              }else if(selectedDateRange == null ){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: red,
                    content: TextWidget(
                      content: "please select the date",
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: white,
                    )));
              }else {
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
                    date: selectedDateRange!
                    );
                await addExpense(expenses: expenseData);
                await expenseToList(tripId: widget.tripId);
                // ignore: use_build_context_synchronously
                Get.back();
              }
            });
  }

  catogoryDialogue({required context}) => Get.defaultDialog(
      title: "Select Cotegory",
      titleStyle: const TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
      titlePadding:const EdgeInsets.only(right: 130, top: 20, bottom: 20),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                  text: "Groceries", image: groceries, color: groceriesColor),
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
              child: const Text("Close")),
        )
      ],
    );

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
