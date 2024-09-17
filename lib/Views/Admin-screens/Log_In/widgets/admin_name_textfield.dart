
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_travelo_app/Views/Screens/Widgets/textFormFeilds.dart';
import 'package:my_travelo_app/constants/constable.dart';

class AdminNameTextField extends StatelessWidget {
  const AdminNameTextField({
    super.key,
    required TextEditingController adminNameController,
  }) : _adminNameController = adminNameController;

  final TextEditingController _adminNameController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 10.w),
      child: Textformfeilds(
        borderColor: red,
        focusedColor: primaryColor,
        controller: _adminNameController,
        keyboardType: TextInputType.name,
        labelText: "Name",
        labelColor: secondaryColor,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please enter the e-mail";
          }
          return null;
        },
      ),
    );
  }
}