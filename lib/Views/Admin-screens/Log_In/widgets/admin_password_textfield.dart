
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_travelo_app/Views/Screens/Widgets/textFormFeilds.dart';
import 'package:my_travelo_app/constants/constable.dart';

class AdminPasswordTextField extends StatelessWidget {
  const AdminPasswordTextField({
    super.key,
    required TextEditingController adminPasswordController,
  }) : _adminPasswordController = adminPasswordController;

  final TextEditingController _adminPasswordController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 10.w),
      child: Textformfeilds(
        borderColor: red,
        controller: _adminPasswordController,
        focusedColor: primaryColor,
        keyboardType: TextInputType.visiblePassword,
        labelText: "Password",
        labelColor: secondaryColor,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please enter the password";
          }
          return null;
        },
      ),
    );
  }
}