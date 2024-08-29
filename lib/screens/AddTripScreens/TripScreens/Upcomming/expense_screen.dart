import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:my_travelo_app/Functions/signIn_service.dart';
import 'package:my_travelo_app/Functions/user_functions.dart';
import 'package:my_travelo_app/Widgets/show_dialogues.dart';
import 'package:my_travelo_app/constants/constable.dart';
import 'package:my_travelo_app/constants/constant.dart';
import 'package:my_travelo_app/models/singInModel.dart';
import 'package:my_travelo_app/models/user_model.dart';
import 'package:lottie/lottie.dart';
import 'package:my_travelo_app/screens/AddTripScreens/TripScreens/Upcomming/add_expense_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExpenseScreen extends StatefulWidget {
  final String tripId;

  const ExpenseScreen({super.key, required this.tripId});

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  Signinservice _signinservice = Signinservice();
  Singinmodel? profileData;
  @override
  void initState() {
    super.initState();

    expenseToList(tripId: widget.tripId);
  }

  //  Future<void> _loadProfileData() async {
  //   SharedPreferences prefz = await SharedPreferences.getInstance();
  //   final currentUserId = prefz.getString("currentuserId");
  //   log("recieved currentuderId is :$currentUserId");
  //   if (currentUserId != null) {
  //     profileData = await _signinservice.getSignInDataById(currentUserId);
  //   }
  //   setState(() {});
  // }

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
                          content: "Spending\n today",
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
          Expanded(
              child: ValueListenableBuilder(
            valueListenable: expenseListener,
            builder: (context, value, child) {
              return expenseListener.value.isNotEmpty
                  ? ListView.builder(
                      itemCount: value.length,
                      itemBuilder: (context, index) {
                        ExpenseModel data = value[index];

                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: RepaintBoundary(
                            child: Stack(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            RepaintBoundary(
                                              child: Container(
                                                width: 75,
                                                height: 60,
                                                margin: const EdgeInsets.only(
                                                    left: 10),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: SvgPicture.asset(
                                                    data.image,
                                                    height: 55,
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                TextWidget(
                                                    content: "₹ ${data.amount}",
                                                    fontSize: 25,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      top: 5),
                                                  width: 120,
                                                  child: Center(
                                                    child: Text(
                                                      data.discription ?? '',
                                                      overflow:
                                                          TextOverflow.ellipsis,
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
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        Navigator.of(context)
                                                            .push(
                                                                MaterialPageRoute(
                                                          builder: (context) =>
                                                              AddExpenseScreen(
                                                            tripId:
                                                                widget.tripId,
                                                            editExpense: data,
                                                          ),
                                                        ));
                                                      },
                                                      child: Container(
                                                        width: 42,
                                                        height: 42,
                                                        decoration:
                                                            const BoxDecoration(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        214,
                                                                        214,
                                                                        214,
                                                                        1),
                                                                shape: BoxShape
                                                                    .circle),
                                                        child: const Center(
                                                          child: Icon(
                                                              Icons.edit_note),
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
                                                              deleteExpense(
                                                                  expense:
                                                                      data);
                                                              expenseToList(
                                                                  tripId: data
                                                                      .tripId);
                                                              log("delete pressed");
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            });
                                                      },
                                                      child: Container(
                                                        width: 42,
                                                        height: 42,
                                                        decoration:
                                                            BoxDecoration(
                                                                color: Colors
                                                                    .grey[350],
                                                                shape: BoxShape
                                                                    .circle),
                                                        child: const Center(
                                                          child: Icon(
                                                            Icons
                                                                .delete_outlined,
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
                                        color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(20)),
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
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AddExpenseScreen(
              tripId: widget.tripId,
            ),
          ));
        },
        child: const Icon(
          Icons.add,
          color: white,
        ),
      ),
    );
  }
}
