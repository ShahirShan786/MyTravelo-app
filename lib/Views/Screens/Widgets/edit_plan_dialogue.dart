import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_travelo_app/Views/Screens/Widgets/textFormFeilds.dart';
import 'package:my_travelo_app/constants/constable.dart';
import 'package:my_travelo_app/constants/constant.dart';

class EditPlanDialogue {
  final BuildContext context;
  final Function(String) addplan;

  late TextEditingController editPlanController;

  EditPlanDialogue({required this.context, required this.addplan}) {
    editPlanController = TextEditingController();
  }

  void showEditPlanDialogue() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: TextWidget(
                content: "Add Plans",
                fontSize: 20.sp,
                fontWeight: FontWeight.bold),
            content: Textformfeilds(
              borderColor: secondaryColor,
              focusedColor: black,
              controller: editPlanController,
              labelText: "Add your plan",
              labelColor: secondaryColor,
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: TextWidget(
                      content: "Cancel",
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600)),
              TextButton(
                  onPressed: () {
                    if (editPlanController.text.isNotEmpty) {
                      addplan(editPlanController.text);
                    }
                    Navigator.of(context).pop();
                  },
                  child: TextWidget(
                      content: "Add",
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600))
            ],
          );
        });
  }
}
