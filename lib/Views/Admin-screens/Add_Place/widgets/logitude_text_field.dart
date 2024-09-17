
import 'package:flutter/widgets.dart';
import 'package:my_travelo_app/Views/Screens/Widgets/text_form_feild.dart';

class BuildLogitudeTextField extends StatelessWidget {
  const BuildLogitudeTextField({
    super.key,
    required TextEditingController logController,
  }) : _logController = logController;

  final TextEditingController _logController;

  @override
  Widget build(BuildContext context) {
    return TextFormFeild(
      hintText: "longitude value of the place",
      controller: _logController,
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