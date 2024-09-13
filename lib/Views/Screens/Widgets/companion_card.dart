import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_travelo_app/constants/constable.dart';
import 'package:my_travelo_app/constants/constant.dart';

class CompanionCard extends StatelessWidget {
  String? title;
  IconData? icon;
  final VoidCallback onPressed;
  CompanionCard({
    required this.title,
    required this.icon,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 60,
          child: InkWell(
            onTap: onPressed,
            child: ListTile(
              leading: Padding(
                padding:const EdgeInsets.only(
                  top: 5,
                ),
                child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 25,
                    child: FaIcon(
                      icon,
                      color: primaryColor,
                      size: 18,
                    )),
              ),
              title: Padding(
                padding: const EdgeInsets.only(right: 50),
                child: SizedBox(
                  width: 200,
                  height: 40,
                  child: Center(
                    child: TextWidget(
                        content: title,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
