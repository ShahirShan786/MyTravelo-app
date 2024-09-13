
import 'package:flutter/widgets.dart';
import 'package:my_travelo_app/constants/constable.dart';
import 'package:my_travelo_app/constants/constant.dart';
import 'package:my_travelo_app/Models/user_model.dart';

class CompanionBox extends StatelessWidget {
  final List<String> companion;
  // final int index;
  final TripModel trip;
  const CompanionBox({super.key, required this.companion, required this.trip,
  //  required this.index
   });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
                    width: double.infinity,
                    height: 140,
                    // color: Colors.blueAccent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                            content: "Companions :",
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                        SizedBox(
                          width: double.infinity,
                          height: 115,
                          // color: Colors.amber,
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GridView.builder(
                                itemCount: trip.companion.length,
                                gridDelegate:
                                  const  SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        mainAxisSpacing: 6,
                                        crossAxisSpacing: 5,
                                        childAspectRatio: 4),
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 3,
                                    ),
                                    child: Container(
                                      padding:const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      decoration: BoxDecoration(
                                          color: ScaffoldColor,
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: Center(
                                        child: Text(companion[index]),
                                      ),
                                    ),
                                  );
                                }),
                          )),
                        ),
                      ],
                    ),
                  );
  }
}