
import 'package:flutter/widgets.dart';
import 'package:my_travelo_app/Views/Screens/Widgets/text_form_feild.dart';

class BuildPlaceTextFields extends StatelessWidget {
  const BuildPlaceTextFields({
    super.key,
    required TextEditingController placeController,
  }) : _placeController = placeController;

  final TextEditingController _placeController;

  @override
  Widget build(BuildContext context) {
    return TextFormFeild(
      hintText: "Name of place",
      controller: _placeController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter the place name";
        }
        return null;
      },
    );
  }
}