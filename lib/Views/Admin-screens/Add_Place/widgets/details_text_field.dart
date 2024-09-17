
import 'package:flutter/widgets.dart';
import 'package:my_travelo_app/Views/Screens/Widgets/text_form_feild.dart';

class BuildDetailsTextField extends StatelessWidget {
  const BuildDetailsTextField({
    super.key,
    required TextEditingController detailsController,
  }) : _detailsController = detailsController;

  final TextEditingController _detailsController;

  @override
  Widget build(BuildContext context) {
    return TextFormFeild(
      maxLength: 4,
      hintText: "details of the place",
      controller: _detailsController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter the destination";
        }
        return null;
      },
    );
  }
}