import 'package:flutter/material.dart';
import 'package:my_travelo_app/Controller/Hive/user_functions.dart';
import 'package:my_travelo_app/constants/constable.dart';
import 'package:my_travelo_app/constants/constant.dart';
import 'package:my_travelo_app/constants/primary_button.dart';
import 'package:my_travelo_app/Models/user_model.dart';

class BlogPage extends StatelessWidget {
  final TripModel trip;
  final String startDate;
  final String endDate;
  final CompletedTripModelBlog? blog;
  BlogPage({super.key, required this.trip, this.blog, required this.startDate, required this.endDate});
  TextEditingController blogController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: TextWidget(
          content: "Add your Blog",
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                  content: "To ${trip.destination}",
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            const  SizedBox(
                height: 10,
              ),
              TextWidget(
                  content: "Start on $startDate to $endDate",
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            const  SizedBox(
                height: 20,
              ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  label: TextWidget(
                      content: "Write about trip",
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
                maxLines: 2,
                controller: blogController,
              ),
            const  SizedBox(
                height: 20,
              ),
              Center(
                child: PrimaryButton(
                    backgroundColor: primaryColor,
                    content: TextWidget(
                        content: "Add",
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    width: 350,
                    height: 50,
                    onPressed: () async{
                           if(blogController.value.text.isNotEmpty){
                            addBlogs(blog: CompletedTripModelBlog(
                              blog: blogController.text,
                               id: blog != null ?
                                blog!.id
                                : DateTime.now().millisecondsSinceEpoch.toString(),
                               tripId: trip.id));
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
