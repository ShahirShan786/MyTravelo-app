
import 'package:flutter/widgets.dart';
import 'package:my_travelo_app/Views/Screens/Widgets/text_form_feild.dart';

class BuildLattitudeTextField extends StatelessWidget {
  const BuildLattitudeTextField({
    super.key,
    required TextEditingController latController,
  }) : _latController = latController;

  final TextEditingController _latController;

  @override
  Widget build(BuildContext context) {
    return TextFormFeild(
      hintText: "lattutude value of the place",
      controller: _latController,
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter the lattitude";
        }
        return null;
      },
    );
  }
}