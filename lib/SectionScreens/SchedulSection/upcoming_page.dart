import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_travelo_app/constants/constant.dart';

class UpcomingPage extends StatelessWidget {
  const UpcomingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: 3,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              color: Colors.blue[50],
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 115,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 32,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 6,
                              ),
                              TextWidget(
                                  content: "$index",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                              TextWidget(
                                  content: "Wed",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600)
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: SizedBox(
                            width: 274,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 15,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextWidget(
                                          content: "Vagamon",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                      TextWidget(
                                          content: "04 : 07PM",
                                          fontSize: 13,
                                          fontWeight: FontWeight.normal)
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextWidget(
                                          content: "19 jun 2024 to 21 jun 2024",
                                          fontSize: 13,
                                          fontWeight: FontWeight.normal),
                                      IconButton(
                                          onPressed: () {},
                                          icon: Icon(Icons.edit_note_outlined))
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
            );
          }),
    );
  }
}
