import 'package:flutter/material.dart';

class PictureSection extends StatelessWidget {
  List<String>? subImages;
  PictureSection({super.key, required this.subImages});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: subImages?.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 55,
            width: 55,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                "https://media.istockphoto.com/id/1281421659/photo/waterfall-falling-from-mountain-too-at-morning-from-low-angle.webp?b=1&s=170667a&w=0&k=20&c=H-I9RBOy44ZRSkL_0ztHVf9Omv5rU0t4zOB4jgs2r_4=",
                fit: BoxFit.cover,
              ),
            ),
          );
        });
  }
}
