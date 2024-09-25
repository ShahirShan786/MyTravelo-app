import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_travelo_app/Controller/Hive/user_functions.dart';
import 'package:my_travelo_app/Views/Screens/Trip_Screens/Completed_Screens/completed_details_page.dart';
import 'package:my_travelo_app/constants/constable.dart';
import 'package:my_travelo_app/constants/constant.dart';
import 'package:my_travelo_app/constants/primary_button.dart';
import 'package:my_travelo_app/Models/user_model.dart';

class BlogPage extends StatefulWidget {
  final TripModel trip;
  final String startDate;
  final String endDate;
  final CompletedTripModelBlog? blog;
  const BlogPage(
      {super.key,
      required this.trip,
      this.blog,
      required this.startDate,
      required this.endDate});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  TextEditingController blogController = TextEditingController();

  @override
  void initState() {
    
    super.initState();
    widget.blog != null ? blogController.text = widget.blog!.blog : "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: TextWidget(
          content: "Add your Blog",
          fontSize: 20.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.all(8.0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                  content: "To ${widget.trip.destination}",
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold),
               SizedBox(
                height: 10.w,
              ),
              TextWidget(
                  content: "Start on ${widget.startDate} to ${widget.endDate}",
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600),
               SizedBox(
                height: 20.h,
              ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r)),
                  label: TextWidget(
                      content: "Write about trip",
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500),
                ),
                maxLines: 2,
                controller: blogController,
              ),
               SizedBox(
                height: 20.h,
              ),
              Center(
                child: PrimaryButton(
                    backgroundColor: primaryColor,
                    content: TextWidget(
                        content: "Add",
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold),
                    width: 350.w,
                    height: 50.h,
                    onPressed: () async {
                      if (blogController.value.text.isNotEmpty) {
                        addBlogs(
                            blog: CompletedTripModelBlog(
                                blog: blogController.text,
                                id: widget.blog != null
                                    ? widget.blog!.id
                                    : DateTime.now()
                                        .millisecondsSinceEpoch
                                        .toString(),
                                tripId: widget.trip.id));
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CompletedDetailsPage(trip: widget.trip)),
                            (Route<dynamic> route) => false);
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
