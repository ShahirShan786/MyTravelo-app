
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:my_travelo_app/Controller/Firebase/firebase_functions.dart';

class HomePictureStreem extends StatelessWidget {
  const HomePictureStreem({
    super.key,
    required this.fireStoreServices,
  });

  final FireStoreServices fireStoreServices;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('homePictures')
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
    
        if (snapshot.hasError) {
          return const Center(
            child: Text('Error loading images'),
          );
        }
    
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text('No images available'),
          );
        }
    
        return GridView.builder(
          shrinkWrap: true,
          physics:
              const NeverScrollableScrollPhysics(), // Since it's inside SingleChildScrollView
          gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount:
                2, // You can set this to 1 if you prefer one image per row
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            childAspectRatio:
                1.5, // Adjust based on your desired aspect ratio
          ),
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (BuildContext context, int index) {
            final imageUrl =
                snapshot.data!.docs[index]['homePictures'];
            final imageId = snapshot.data!.docs[index].id;
            return InkWell(
              onLongPress: () {
                Get.defaultDialog(
                  contentPadding: EdgeInsets.symmetric(
                      vertical: 10.h, horizontal: 5.w),
                  titlePadding: EdgeInsets.only(right: 120.w, top: 10.h),
                  title: 'Delete Image',
                  titleStyle: TextStyle(
                      fontSize: 24.sp, fontWeight: FontWeight.bold),
                  content: Column(
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      const Text(
                          'Are you sure you want to delete this image?'),
                      SizedBox(
                        height: 20.h,
                      ),
                    ],
                  ),
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: const Text("Cancel")),
                        SizedBox(width: 8.w),
                        TextButton(
                            onPressed: () {
                              fireStoreServices.deleteHomePicture(
                                  id: imageId);
                            },
                            child: const Text("Delete"))
                      ],
                    ),
                  ],
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.error),
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        );
      },
    );
  }
}