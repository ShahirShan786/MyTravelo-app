import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_travelo_app/constants/constable.dart';
import 'package:my_travelo_app/constants/constant.dart';
import 'package:my_travelo_app/Models/user_model.dart';

class CompanionBox extends StatelessWidget {
  final List<String> companion;
  // final int index;
  final TripModel trip;
  const CompanionBox({
    super.key,
    required this.companion,
    required this.trip,
    //  required this.index
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      // height: 140.h,
      // color: Colors.blueAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
              content: "Companions :",
              fontSize: 20.sp,
              fontWeight: FontWeight.w600),
          SizedBox(
            width: double.infinity,
            height: 115.h,
            // color: Colors.amber,
            child: Center(
                child: Padding(
              padding:  EdgeInsets.all(8.0.w),
              child: GridView.builder(
                  itemCount: trip.companion!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 6,
                      crossAxisSpacing: 5,
                      childAspectRatio: 4),
                  itemBuilder: (context, index) {
                    return Padding(
                        padding:  EdgeInsets.symmetric(
                          horizontal: 3.w,
                        ),
                        child: companion.isNotEmpty
                            ? Container(
                                padding:  EdgeInsets.symmetric(
                                    horizontal: 10.w, vertical: 5.h),
                                decoration: BoxDecoration(
                                    color: ScaffoldColor,
                                    borderRadius: BorderRadius.circular(30.r)),
                                child: Center(
                                  child: Text(companion[index]),
                                ),
                              )
                            : const SizedBox());
                  }),
            )),
          ),
        ],
      ),
    );
  }
}
