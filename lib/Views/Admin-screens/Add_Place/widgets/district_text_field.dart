
import 'package:flutter/widgets.dart';
import 'package:my_travelo_app/Views/Screens/Widgets/text_form_feild.dart';

class BuildDistrictTextField extends StatelessWidget {
  const BuildDistrictTextField({
    super.key,
    required TextEditingController districtController,
  }) : _districtController = districtController;

  final TextEditingController _districtController;

  @override
  Widget build(BuildContext context) {
    return TextFormFeild(
      hintText: "destrict",
      controller: _districtController,
      
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter the destination";
        }
        return null;
      },
    );
  }
}